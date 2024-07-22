#!/bin/bash
#
# Author: Bertrand Benoit <mailto:contact@bertrand-benoit.net>
# Version: 2.1.1
#
# Description: Free common utilities/tool-box for GNU/Bash scripts.
#
# Optional variables you can define before sourcing this file:
#  BSC_ROOT_DIR               <path>  root directory to consider when performing various check
#  BSC_TMP_DIR                <path>  temporary directory where various dump files are created
#  BSC_PID_DIR                <path>  directory where PID files are created to manage daemon feature
#  BSC_CONFIG_FILE            <path>  path of configuration file
#  BSC_GLOBAL_CONFIG_FILE     <path>  path of GLOBAL configuration file
#
#  BSC_DISABLE_ERROR_TRAP       0|1   disable TRAP on error (recommended only for Tests project where assert leads to 'error')
#  BSC_DEBUG_UTILITIES          0|1   enable Debug mode (not recommended in production)
#  BSC_FORCE_COMPAT_MODE        0|1   enable compatibility mode (not recommended in production)
#  BSC_VERBOSE                  0|1   enable Verbose mode, showing INFO messages (not recommended in production)
#  BSC_CATEGORY             <string>  the category which prepends all messages
#  BSC_LOG_CONSOLE_OFF          0|1   disable message output on console
#  BSC_LOG_FILE               <path>  path of the log file
#  BSC_MODE_CHECK_CONFIG        0|1   check ALL configuration and then quit (useful to check all the configuration you want, +/- like a dry run)
#  BSC_DAEMON_STOP_TIMEOUT <integer>  timeout (in seconds) before killing a daemon process after stop request

# N.B.:
#  - when a configuration element is not found in **BSC_CONFIG_FILE**, system checks the **BSC_GLOBAL_CONFIG_FILE**
#  - when using `checkAndSetConfig` function, you can get result in **BSC_LAST_READ_CONFIG** variable (will be set to *$BSC_CONFIG_NOT_FOUND* if not existing)
#  - when using `listConfigKeys` or `loadConfigKeyValueList` functions, you can get result in **BSC_LAST_READ_CONFIG_KEY_VALUE_LIST** variable

# You should never have to update this script directly, see README.md file if you need to report an issue requesting more configurability.

#########################
## Global configuration
# Cf. http://www.gnu.org/software/bash/manual/bashref.html#The-Shopt-Builtin
# Ensures respect to quoted arguments to the conditional command's =~ operator.
#shopt -s compat31

# Used variables MUST be initialized.
set -o nounset
# Traces error in function & co.
set -o errtrace

# shellcheck disable=SC2154
# Dumps function call in case of error, or when exiting with something else than status 0.
[ "${BSC_DISABLE_ERROR_TRAP:-0}" -eq 0 ] && trap '_status=$?; dumpFuncCall $_status' ERR
#trap '_status=$?; [ $_status -ne 0 ] && dumpFuncCall $_status' EXIT

# N.B.: since version 2.1, global variable definition are at end of this script
#       (required by compatibility mode implementation, based on some functions)

#########################
## Constants
# Log Levels.
declare -r _BSC_LOG_LEVEL_INFO=1
declare -r _BSC_LOG_LEVEL_MESSAGE=2
declare -r _BSC_LOG_LEVEL_WARNING=3
declare -r _BSC_LOG_LEVEL_ERROR=4
declare -r _BSC_LOG_NO_MESSAGE="/!\ NO MESSAGE SPECIFIED /!\ (May be you attempt to print an empty variable ?)"

# Configuration element types.
declare -r BSC_CONFIG_NOT_FOUND="CONFIG NOT FOUND"
declare -r BSC_CONFIG_TYPE_PATH=1
declare -r BSC_CONFIG_TYPE_OPTION=2
declare -r BSC_CONFIG_TYPE_BIN=3
declare -r BSC_CONFIG_TYPE_DATA=4

## Error code
# Default error message code.
declare -r BSC_ERROR_DEFAULT=101

# Error code after showing usage.
declare -r BSC_ERROR_USAGE=102

# Command line syntax not respected.
declare -r BSC_ERROR_BAD_CLI=103

# Bad/incomplete environment, like:
#  - missing Java or Ant
#  - bad user
#  - permission issue (e.g. while updating structure)
declare -r BSC_ERROR_ENVIRONMENT=104

# Invalid configuration, or path definition.
declare -r BSC_ERROR_CONFIG_VARIOUS=105
declare -r BSC_ERROR_CONFIG_PATH=106

# Binary or data configured file not found.
declare -r BSC_ERROR_CHECK_BIN=107
declare -r BSC_ERROR_CHECK_CONFIG=108

# PID Files.
declare -r BSC_ERROR_PID_FILE=120

# Daemon feature actions.
declare -r BSC_DAEMON_ACTION_START="start"
declare -r BSC_DAEMON_ACTION_STATUS="status"
declare -r BSC_DAEMON_ACTION_STOP="stop"
declare -r BSC_DAEMON_ACTION_DAEMON="daemon"
declare -r BSC_DAEMON_ACTION_RUN="run"

# Daemon feature CLI options.
declare -r BSC_DAEMON_OPTION_RUN="-R"
declare -r BSC_DAEMON_OPTION_DAEMON="-D"

#########################
## Functions - Debug

# usage: dumpFuncCall <exit status>
function dumpFuncCall() {
  # Defines count of function names.
  local _exitStatus="${1:-?}" _funcNameCount="${#FUNCNAME[@]}"

  # Ignores following exit status:
  #  BSC_ERROR_USAGE: used in usage method (error will have already been shown)
  #  BSC_ERROR_BAD_CLI: bad CLI use (error will have already been shown)
  #  BSC_ERROR_INPUT_PROCESS: an error message will be said
  #  BSC_ERROR_CHECK_BIN an error message will be shown
  #  BSC_ERROR_CHECK_CONFIG an error message will be shown
  [ "$_exitStatus" -eq $BSC_ERROR_USAGE ] && return 0
  [ "$_exitStatus" -eq $BSC_ERROR_BAD_CLI ] && return 0
  [ "$_exitStatus" -eq $BSC_ERROR_CHECK_BIN ] && return 0
  [ "$_exitStatus" -eq $BSC_ERROR_CHECK_CONFIG ] && return 0
  [ "$_exitStatus" -eq $BSC_ERROR_CONFIG_VARIOUS ] && return 0
  [ "$_exitStatus" -eq $BSC_ERROR_CONFIG_PATH ] && return 0

  # Ignores the call if the system is currently in _doWriteMessage, in which
  #  case the exit status has been "manually" executed after error message shown.
  [ "${FUNCNAME[1]}" = "_doWriteMessage" ] && return 0
  [ "${FUNCNAME[1]}" = "errorMessage" ] && return 0

  # Prepares message begin.
  message="Script failure with status $_exitStatus, stacktrace:"

  # Starts to 1 to avoid THIS function name, and stops before the last one to avoid "main".
  local _verb="triggered"
  for index in $( eval echo "{0..$((_funcNameCount-2))}" ); do
    message="$message\n"
    message="$message at ${BASH_SOURCE[$index+1]}:${BASH_LINENO[$index]}\t\t$_verb\t#${FUNCNAME[$index]}"
    _verb="called\t"
  done

  warning "$message"
  return 0
}


#########################
## Functions - Environment check and utilities

# usage: isCheckModeConfigOnly
function isCheckModeConfigOnly() {
  [ "$BSC_MODE_CHECK_CONFIG" -eq 1 ]
}

# usage: isRootUser
function isRootUser() {
  [[ "$( whoami )" == "root" ]]
}

# usage: checkLocale
function checkLocale() {
  ! isCheckModeConfigOnly && info "Checking LANG environment variable ... "

  # Checks LANG is defined with UTF-8.
  if [ "$( echo "$LANG" |grep -ci "[.]utf[-]*8" )" -eq 0 ] ; then
      # It is a fatal error but in 'BSC_MODE_CHECK_CONFIG' mode.
      warning "You must update your LANG environment variable to use the UTF-8 charmaps ('${LANG:-NONE}' detected). Until then system will attempt using en_US.UTF-8."

      export LANG="en_US.UTF-8"
      return $BSC_ERROR_ENVIRONMENT
  fi

  # Ensures defined LANG is avaulable on the OS.
  if [ "$( locale -a 2>/dev/null |grep -ci $LANG )" -eq 0 ] && [ "$( locale -a 2>/dev/null |grep -c "${LANG//UTF[-]*8/utf8}" )" -eq 0 ]; then
    # It is a fatal error but in 'BSC_MODE_CHECK_CONFIG' mode.
    warning "Although the current OS locale '$LANG' defines to use the UTF-8 charmaps, it is not available (checked with 'locale -a'). You must install it or update your LANG environment variable. Until then system will attempt using en_US.UTF-8."

    export LANG="en_US.UTF-8"
    return $BSC_ERROR_ENVIRONMENT
  fi

  return 0
}


#########################
## Functions - Logger Feature

# usage: _doWriteMessage <level> <message> <newline> <exit code>
# <level>: _BSC_LOG_LEVEL_INFO|_BSC_LOG_LEVEL_MESSAGE|_BSC_LOG_LEVEL_WARNING|_BSC_LOG_LEVEL_ERROR
# <message>: the message to show
# <newline>: 0 to stay on same line, 1 to break line
# <exit code>: the exit code (usually for ERROR message), -1 for NO exit.
#
# N.B.: you should NEVER call this function directly.
function _doWriteMessage() {
  local _level="$1" _message="$2" _newLine="${3:-1}" _exitCode="${4:--1}"

  # Safe-guard on numeric values (if this function is directly called).
  [ "$( echo "$_newLine" |grep -ce "^[0-9]$" )" -ne 1 ] && _newLine="1"
  [ "$( echo "$_exitCode" |grep -ce "^-*[0-9][0-9]*$" )" -ne 1 ] && _exitCode="-1"

  # Does nothing if INFO message and NOT BSC_VERBOSE.
  [ "$BSC_VERBOSE" -eq 0 ] && [ "$BSC_DEBUG_UTILITIES" -eq 0 ] && [ "$_level" = "$_BSC_LOG_LEVEL_INFO" ] && return 0

  # Manages level.
  _messagePrefix=""
  [ "$_level" = "$_BSC_LOG_LEVEL_INFO" ] && _messagePrefix="INFO: "
  [ "$_level" = "$_BSC_LOG_LEVEL_WARNING" ] && _messagePrefix="\E[31m\E[4mWARNING\E[0m: "
  [ "$_level" = "$_BSC_LOG_LEVEL_ERROR" ] && _messagePrefix="\E[31m\E[4mERROR\E[0m: "

  [ "$_newLine" -eq 0 ] && printMessageEnd="" || printMessageEnd="\n"

  # Checks if message must be shown on console.
  _timestamp=$( getFormattedDatetime "$BSC_TIME_FORMAT" )
  if [ "$BSC_LOG_CONSOLE_OFF" -eq 0 ]; then
    printf "%-17s %-15s $_messagePrefix%b$printMessageEnd" "$_timestamp" "[$BSC_CATEGORY]" "$_message" |tee -a "$BSC_LOG_FILE"
  else
    printf "%-17s %-15s $_messagePrefix%b$printMessageEnd" "$_timestamp" "[$BSC_CATEGORY]" "$_message" >> "$BSC_LOG_FILE"
  fi

  # Manages exit if needed.
  [ "$_exitCode" -eq -1 ] && return 0
  [ "$BSC_ERROR_MESSAGE_EXITS_SCRIPT" -eq 0 ] && return "$_exitCode"
  exit "$_exitCode"
}

# usage: writeOK
# Utility method aiming only to print "OK", in accordance with logging configuration.
function writeOK() {
  if [ "$BSC_LOG_CONSOLE_OFF" -eq 0 ]; then
    printf "OK\n" |tee -a "$BSC_LOG_FILE"
  else
    printf "OK\n" >> "$BSC_LOG_FILE"
  fi
}

# usage: writeNotFound [<element>]
# Utility method aiming only to print "NOT FOUND", in red, in accordance with logging configuration.
function writeNotFound() {
  local _element="${1:-}"

  if [ "$BSC_LOG_CONSOLE_OFF" -eq 0 ]; then
    printf "'%b' \E[31mNOT FOUND\E[0m\n" "$_element" |tee -a "$BSC_LOG_FILE"
  else
    printf "'%b' \E[31mNOT FOUND\E[0m\n" "$_element" >> "$BSC_LOG_FILE"
  fi
}

# usage: writeMessage <message>
# Shows the message, and moves to next line.
function writeMessage() {
  _doWriteMessage $_BSC_LOG_LEVEL_MESSAGE "${1:-$_BSC_LOG_NO_MESSAGE}" "${2:-1}" -1
}

# usage: writeMessageSL <message>
# Shows the message, and stays to same line.
function writeMessageSL() {
  _doWriteMessage $_BSC_LOG_LEVEL_MESSAGE "${1:-$_BSC_LOG_NO_MESSAGE}" 0 -1
}

# usage: info <message> [<0 or 1>]
# Shows message only if $BSC_VERBOSE is ON.
# Stays on the same line if "0" has been specified
function info() {
  _doWriteMessage $_BSC_LOG_LEVEL_INFO "${1:-$_BSC_LOG_NO_MESSAGE}" "${2:-1}"
}

# usage: warning <message> [<0 or 1>]
# Shows warning message.
# Stays on the same line if "0" has been specified
function warning() {
  _doWriteMessage $_BSC_LOG_LEVEL_WARNING "${1:-$_BSC_LOG_NO_MESSAGE}" "${2:-1}" >&2
}

# usage: errorMessage <message> [<exit code>]
# Shows error message and exits.
function errorMessage() {
  _doWriteMessage $_BSC_LOG_LEVEL_ERROR "${1:-$_BSC_LOG_NO_MESSAGE}" 1 "${2:-$BSC_ERROR_DEFAULT}" >&2
}


#########################
## Functions - [Check]Path Feature

# usage: updateStructure <dir path>
function updateStructure() {
  mkdir -p "$1" || errorMessage "Unable to create structure pieces (check permissions): $1" $BSC_ERROR_ENVIRONMENT
}

# usage: isEmptyDirectory <path>
function isEmptyDirectory()
{
  local _dir="${1:-}"
  [[ -n "$_dir" && -d "$_dir" && "$( find "$_dir" -maxdepth 0 2>/dev/null|wc -l )" -eq 1 ]]
}

# usage: pruneSlash <path>
# Prunes ending slash, prunes useless slash in path, and returns purified path.
function pruneSlash() {
  # Unable to perform equivalent instruction only in GNU/Bash (because there is no way to 'say' 'end of line'):
  #  - ${HOME/%\//} -> removes only ONE ending slash if any
  #  - ${HOME/%\/\/*/} -> removes everything even if there is path pieces after last slash.
  echo "$1" |sed -e 's/\/\/*/\//g;s/^\(.[^\/][^\/]*\)\/\/*$/\1/;s/^\(.*\)\/$/\1/'
}

# usage: isRelativePath <path>
# "true" if there is NO "/" character (and so the tool should be in PATH)
function isRelativePath() {
  [[ "$1" =~ ^[^/]*$ ]]
}

# usage: isAbsolutePath <path>
# "true" if the path begins with "/"
function isAbsolutePath() {
  [[ "$1" =~ ^/.*$ ]]
}

# usage: checkPath <path>
function checkPath() {
  local _path="$1"

  # Informs only if not in 'BSC_MODE_CHECK_CONFIG' mode.
  ! isCheckModeConfigOnly && info "Checking path '$_path' ... "

  # Checks if the path exists.
  [ -e "$_path" ] && return 0

  # It is not the case, if NOT in 'BSC_MODE_CHECK_CONFIG' mode, it is a fatal error.
  ! isCheckModeConfigOnly && errorMessage "Unable to find '$_path'." $BSC_ERROR_CHECK_CONFIG
  # Otherwise, simple returns an error code.
  return $BSC_ERROR_CHECK_CONFIG
}

# usage: checkBin <binary name/path>
function checkBin() {
  local _binary="$1" _full_path

  # Informs only if not in 'BSC_MODE_CHECK_CONFIG' mode.
  ! isCheckModeConfigOnly && info "Checking binary '$_binary' ... "

  # Checks if the binary is available.
  _full_path=$( command -v "$_binary" )
  commandStatus=$?
  if [ $commandStatus -ne 0 ]; then
    # It is not the case, if NOT in 'BSC_MODE_CHECK_CONFIG' mode, it is a fatal error.
    ! isCheckModeConfigOnly && errorMessage "Unable to find binary '$_binary'." $BSC_ERROR_CHECK_BIN
  else
    # Checks if the binary has "execute" permission.
    [ -x "$_full_path" ] && return 0

    # It is not the case, if NOT in 'BSC_MODE_CHECK_CONFIG' mode, it is a fatal error.
    ! isCheckModeConfigOnly && errorMessage "Binary '$_binary' found but it does not have *execute* permission." $BSC_ERROR_CHECK_BIN
  fi

  # Otherwise, simple returns an error code.
  return $BSC_ERROR_CHECK_BIN
}

# usage: checkDataFile <data file path>
function checkDataFile() {
  local _dataFile="$1"

  # Informs only if not in 'BSC_MODE_CHECK_CONFIG' mode.
  ! isCheckModeConfigOnly && info "Checking data file '$_dataFile' ... "

  # Checks if the file exists.
  [ -f "$_dataFile" ] && return 0

  # It is not the case, if NOT in 'BSC_MODE_CHECK_CONFIG' mode, it is a fatal error.
  ! isCheckModeConfigOnly && errorMessage "Unable to find data file '$_dataFile'." $BSC_ERROR_CHECK_CONFIG
  # Otherwise, simple returns an error code.
  return $BSC_ERROR_CHECK_CONFIG
}

# usage: buildCompletePath <path> [<force prepend>] [<path to prepend>]
# <force prepend>: 0=disabled, 1 (default)=force prepend for "single path" (useful for data file)
# <path to prepend>: the path to prepend if the path is NOT absolute and NOT simple.
# Defaut <path to prepend> is $BSC_ROOT_DIR
function buildCompletePath() {
  local _path _forcePrepend="${2:-1}" _pathToPreprend="${3:-$BSC_ROOT_DIR}"
  _path="$( pruneSlash "$1" )"

  # Replaces potential '~' character.
  [[ "$_path" =~ ^~.*$ ]] && _path="${_path//\~/$HOME}"

  # Checks if it is an absolute path.
  isAbsolutePath "$_path" && echo "$_path" && return 0

  # Checks if it is a "simple" path.
  isRelativePath "$_path" && [ "$_forcePrepend" -eq 0 ] && echo "$_path" && return 0

  # Prefixes with path to prepend.
  echo "$_pathToPreprend/$_path"
}

# usage: checkAndFormatPath <paths> [<path to prepend>]
# ALL paths must be specified if a single parameter, separated by colon ':'.
function checkAndFormatPath() {
  local _paths="$1" _pathToPreprend="${2:-$BSC_ROOT_DIR}"

  formattedPath=""
  while IFS= read -r -d ':' pathToCheck; do
    # Defines the completes path, according to absolute/relative path.
    completePath=$( buildCompletePath "$pathToCheck" 1 "$_pathToPreprend" )

    # Uses "ls" to complete the path in case there is wildcard.
    if [[ "$completePath" =~ ^.*[*].*$ ]]; then
      formattedWildcard=$( echo "$completePath" |sed -e 's/^/"/;s/$/"/;s/*/"*"/g;s/""$//;' )
      completePath="$( ls -d "$( eval echo "$formattedWildcard" )" 2>/dev/null )" || writeNotFound
    fi

    # Checks if it exists, if 'BSC_MODE_CHECK_CONFIG' mode.
    if isCheckModeConfigOnly; then
      writeMessageSL "Checking path '$pathToCheck' ... "
      if [ -d "$completePath" ]; then
        writeOK
      else
        writeNotFound
      fi
    fi

    # In any case, updates the formatted path list.
    [ -n "$formattedPath" ] && formattedPath=$formattedPath:
    formattedPath=$formattedPath$completePath
  done <<< "$_paths:" # N.B.: adds an extra ':' to ensure last path element is read and manage.
  echo "$formattedPath"
}


#########################
## Functions - Configuration file feature.

# Lists specific <key, value> pairs from specified configuration file, with optional pattern.
#
# usage: doListConfigKeyValues <config file> [<config key pattern>]
# N.B.: must NOT be called directly.
function doListConfigKeyValues() {
  local _configFile="$1" _configKeyPattern="${2:-.*}"

  grep -v "^[ \t]*#" "$_configFile"|grep -E "^[ \t]*$_configKeyPattern=.*" |sed -e 's/^[ \t]*//'
}

# Loads available configuration <key, value> (merging global and user configuration files).
# Result will then be available in global associative array named $BSC_LAST_READ_CONFIG_KEY_VALUE_LIST.
#
# usage: loadConfigKeyValueList [<search pattern>] [<key remove pattern>]
# <search pattern>: optional regular expression of keys to consider (by default ALL configuration will be considered)
# <key remove pattern>: optional regular expression of key's part to remove in the final associative array (can be useful to use pattern matching with remaining part of key).
function loadConfigKeyValueList() {
  local _searchPattern="${1:-.*}" _keyRemovePattern="${2:-}"

  # Compatibility safe-guard.
  if [ "${BSC_FORCE_COMPAT_MODE:-${_BSC_COMPAT_ASSOCIATIVE_ARRAY:-0}}" -eq 0 ]; then
    # This feature can only work with associative array.
    BSC_LAST_READ_CONFIG_KEY_VALUE_LIST="Your GNU/Bash version '$BASH_VERSION' does not support associative array."
    return
  fi

  declare -gA BSC_LAST_READ_CONFIG_KEY_VALUE_LIST=() # [re]init associative global array

  # Reads all configuration key from global configuration file if any.
  if [ -f "$BSC_GLOBAL_CONFIG_FILE" ]; then
    while IFS='=' read -r configKey configValue; do
      BSC_LAST_READ_CONFIG_KEY_VALUE_LIST["${configKey//$_keyRemovePattern/}"]="${configValue//\"/}"
    done < <( doListConfigKeyValues "$BSC_GLOBAL_CONFIG_FILE" "$_searchPattern" )
  fi

  # Reads all configuration key from user configuration file if any.
  if [ -f "$BSC_CONFIG_FILE" ]; then
    while IFS='=' read -r configKey configValue; do
      BSC_LAST_READ_CONFIG_KEY_VALUE_LIST["${configKey//$_keyRemovePattern/}"]="${configValue//\"/}"
    done < <( doListConfigKeyValues "$BSC_CONFIG_FILE" "$_searchPattern" )
  fi
}

# Lists available configuration key (merging global and user configuration keys).
# usage: listConfigKeys [<pattern>]
function listConfigKeys() {
  local _pattern="${1:-.*}"

  loadConfigKeyValueList "$_pattern"
  echo "${!BSC_LAST_READ_CONFIG_KEY_VALUE_LIST[@]}"
}

# usage: _checkConfigValue <configuration file> <config key>
function _checkConfigValue() {
  local _configFile="$1" _configKey="$2"
  # Ensures configuration file exists ('user' one does not exist for root user;
  #  and 'global' configuration file does not exists for only-standard user installation).
  if [ ! -f "$_configFile" ]; then
    # IMPORTANT: be careful not to print something in the standard output or it would break the checkAndSetConfig feature.
    [ "$BSC_DEBUG_UTILITIES" -eq 1 ] && printf "Configuration file '%b' not found ... " "$_configFile" >&2
    return 1
  fi

  [ "$( doListConfigKeyValues "$_configFile" "$_configKey" |wc -l )" -gt 0 ]
}

# usage: getConfigValue <config key>
function getConfigValue() {
  local _configKey="$1"

  # Checks in use configuration file.
  configFileToRead="$BSC_CONFIG_FILE"
  if ! _checkConfigValue "$configFileToRead" "$_configKey"; then
    # Checks in global configuration file.
    configFileToRead="$BSC_GLOBAL_CONFIG_FILE"
    if ! _checkConfigValue "$configFileToRead" "$_configKey"; then
      # Prints error message (and exit) only if NOT in "check config and quit" mode.
      ! isCheckModeConfigOnly && errorMessage "Configuration key '$_configKey' NOT found in any of configuration files" $BSC_ERROR_CONFIG_VARIOUS
      [ "$BSC_DEBUG_UTILITIES" -eq 1 ] && printf "configuration key '%b' \E[31mNOT FOUND\E[0m in any of configuration files" "$_configKey"
      return $BSC_ERROR_CONFIG_VARIOUS
    fi
  fi

  # Gets the value (may be empty).
  # N.B.: in case there is several, takes only the last one (interesting when there is several definition in configuration file).
  doListConfigKeyValues "$configFileToRead" "$_configKey"|sed -e 's/^[^=]*=//;s/"//g;' |tail -n 1
  return 0
}

# usage: checkAndGetConfig <config key> <config type> [<path to prepend>] [<toggle: must exist>]
# <config key>: the full config key corresponding to configuration element in configuration file
# <config type>: the type of config among
#   $BSC_CONFIG_TYPE_PATH: path -> path existence will be checked
#   $BSC_CONFIG_TYPE_OPTION: options -> nothing more will be done
#   $BSC_CONFIG_TYPE_BIN: binary -> system will ensure binary path is available
#   $BSC_CONFIG_TYPE_DATA: data -> data file path existence will be checked
# <path to prepend>: (only for type $BSC_CONFIG_TYPE_BIN and $BSC_CONFIG_TYPE_DATA) the path to prepend if
#  the path is NOT absolute and NOT simple. Defaut <path to prepend> is $BSC_ROOT_DIR
# <toggle: must exist>: only for BSC_CONFIG_TYPE_PATH; 1 (default) if path must exist, 0 otherwise.
# If all is OK, it defined the BSC_LAST_READ_CONFIG variable with the requested configuration element.
function checkAndSetConfig() {
  local _configKey="$1" _configType="$2" _pathToPreprend="${3:-$BSC_ROOT_DIR}" _pathMustExist="${4:-1}"
  export BSC_LAST_READ_CONFIG="$BSC_CONFIG_NOT_FOUND" # reinit global variable.

  [ -z "$_configKey" ] && errorMessage "checkAndSetConfig function badly used (configuration key not specified)"
  [ -z "$_configType" ] && errorMessage "checkAndSetConfig function badly used (configuration type not specified)"

  local _message="Checking '$_configKey' ... "

  # Informs about config key to check, according to situation:
  #  - in 'normal' mode, message is only shown in BSC_VERBOSE mode
  #  - in 'BSC_MODE_CHECK_CONFIG' mode, message is always shown
  if ! isCheckModeConfigOnly; then
    info "$_message"
  else
    writeMessageSL "$_message"
  fi

  # Gets the value, according to the type of config.
  _value=$( getConfigValue "$_configKey" )
  valueGetStatus=$?
  if [ $valueGetStatus -ne 0 ]; then
    # Prints error message if any.
    [ -n "$_value" ] && echo -e "$_value" |tee -a "$BSC_LOG_FILE"
    # If NOT in 'BSC_MODE_CHECK_CONFIG' mode, it is a fatal error, so exists.
    ! isCheckModeConfigOnly && exit $valueGetStatus
    # Otherwise, simply returns an error status.
    return $valueGetStatus
  fi

  # Manages path if needed (it is the case for PATH, BIN and DATA).
  checkPathStatus=0
  if [ "$_configType" -ne $BSC_CONFIG_TYPE_OPTION ]; then
    [ "$_configType" -ne $BSC_CONFIG_TYPE_BIN ] && forcePrepend=1 || forcePrepend=0
    _value=$( buildCompletePath "$_value" $forcePrepend "$_pathToPreprend" )

    if [ "$_configType" -eq $BSC_CONFIG_TYPE_PATH ] && [ "$_pathMustExist" -eq 1 ]; then
      checkPath "$_value"
      checkPathStatus=$?
    elif [ "$_configType" -eq $BSC_CONFIG_TYPE_BIN ]; then
      checkBin "$_value"
      checkPathStatus=$?
    elif [ "$_configType" -eq $BSC_CONFIG_TYPE_DATA ]; then
      checkDataFile "$_value"
      checkPathStatus=$?
    fi
  fi

  # Ensures path check has been successfully done.
  if [ $checkPathStatus -ne 0 ]; then
    # If NOT in 'BSC_MODE_CHECK_CONFIG' mode, it is a fatal error, so exits.
    ! isCheckModeConfigOnly && exit $checkPathStatus
    # Otherwise, show an error message, and simply returns an error status.
    writeNotFound "$_value"
    return $checkPathStatus
  fi

  # Here, all is OK, there is nothing more to do.
  isCheckModeConfigOnly && writeOK

  # Sets the global variable
  export BSC_LAST_READ_CONFIG="$_value"
  return 0
}


#########################
## Functions - Version Feature

# usage: getVersion <file path> [<default version>]
# This method returns the more recent version of the given ChangeLog/NEWS/README file path.
# It returns the specified default value if file is not found.
function getVersion() {
    local _fileWithVersion="${1:-ChangeLog}" _defaultVersion="${2:-0.1.0}"

    # Lookup the version in the NEWS file (which did not exist in version 0.1)
    [ ! -f "$_fileWithVersion" ] && echo "$_defaultVersion" && return 0

    # Extracts the version.
    grep "version [0-9]" "$_fileWithVersion" |head -n 1 |sed -e 's/^.*version[ \t*]\([0-9][0-9.]*\)[ \t*].*$/\1/;s/^.*version[ \t]\([0-9][0-9.]*\)$/\1/;'
}

# usage: getDetailedVersion <Major Version> <installation directory>
function getDetailedVersion() {
  local _majorVersion="$1" _installDir="$2"

  # General version is given by the specified $_majorVersion.
  # Before all, trying to get precise version in case of source code version.
  lastCommit=$( cd "$_installDir" >/dev/null 2>&1 || exit $BSC_ERROR_ENVIRONMENT; \
                LANG=C git log -1 --abbrev-commit --date=short 2>&1 |grep -wE "commit|Date" |sed -e 's/Date:. / of/' |tr -d '\n' ) \
              || return $BSC_ERROR_ENVIRONMENT

  # Manages the commit Hash.
  [ -n "$lastCommit" ] && lastCommit=" ($lastCommit)"

  # Prints the general version and the potential precise version (will be empty if not defined).
  echo "$_majorVersion$lastCommit"
}

# usage: isVersionGreater <version 1> <version 2> [<orEquals>]
# <version N>: syntax must be dot separated digits (e.g. 0.1.0)
# <orEquals>: 0|1 to turn the function to *isVersionGreaterOrEquals*.
#
# Checks if <version 1> is greater than <version 2>.
# By default, if both versions are equal, function returns false.
# If <orEquals> is defined to 1, and both versions are equal, function returns true.
function isVersionGreater() {
  local _version1="$1" _version2="$2" _orEquals="${3:-0}"

  # Safeguard - ensures syntax is respected.
  [ "$( echo "$_version1" |grep -ce "^[0-9][0-9.]*$" )" -eq 1 ] || errorMessage "Unable to compare version because version '$_version1' does not fit the syntax (digits separated by dot)" $BSC_ERROR_ENVIRONMENT
  [ "$( echo "$_version2" |grep -ce "^[0-9][0-9.]*$" )" -eq 1 ] || errorMessage "Unable to compare version because version '$_version2' does not fit the syntax (digits separated by dot)" $BSC_ERROR_ENVIRONMENT

  # Checks if the version are equals (in which case the first one is NOT greater than the second).
  [[ "$_version1" == "$_version2" ]] && return $((_orEquals-1))

  # Defines arrays with specified versions.
  IFS='.' read -ra _v1Array <<< "$_version1"
  IFS='.' read -ra _v2Array <<< "$_version2"

  # Lookups version element until they are not the same.
  index=0
  while [ "${_v1Array[$index]}" -eq "${_v2Array[$index]}" ]; do
    (( index++ ))

    # Ensures there is another element for each version.
    [ -z "${_v1Array[$index]:-}" ] && v1End=1 || v1End=0
    [ -z "${_v2Array[$index]:-}" ] && v2End=1 || v2End=0

    # Continues on next iteration if NONE is empty.
    [ $v1End -eq 0 ] && [ $v2End -eq 0 ] && continue

    # If the two versions have been fully managed, they are equals (so the first is NOT greater).
    [ $v1End -eq 1 ] && [ $v2End -eq 1 ] && return 1

    # if the first version has not been fully managed, it is greater
    #  than the second (there is still version information), and vice versa.
    [ $v1End -eq 0 ] && return 0 || return 1
  done

  # returns the comparaison of the element with 'index'.
  [ "${_v1Array[$index]}" -gt "${_v2Array[$index]}" ]
}


#########################
## Functions - Time feature

# Usage: getFormattedDate <date Format>
# Date format corresponds to date tool format.
function getFormattedDatetime() {
  local _dateFormat="$1"

  if [ "${BSC_FORCE_COMPAT_MODE:-${_BSC_COMPAT_DATE_PRINTF:-0}}" -eq 1 ]; then
    printf "%($_dateFormat)T" -1
  else
    date +"$_dateFormat"
  fi
}

# usage: initializeUptime
function initializeStartTime() {
  getFormattedDatetime '%s' > "$BSC_TIME_FILE"
}

# usage: finalizeStartTime
function finalizeStartTime() {
  rm -f "$BSC_TIME_FILE"
}

# usage: getUptime
function getUptime() {
  local _currentTime _startTime _uptime
  [ ! -f "$BSC_TIME_FILE" ] && echo "not started" && exit 0

  _currentTime=$( getFormattedDatetime '%s' )
  _startTime=$( <"$BSC_TIME_FILE" )
  _uptime=$((_currentTime - _startTime))

  printf "%02dd %02dh:%02dm.%02ds" $((_uptime/86400)) $((_uptime%86400/3600)) $((_uptime%3600/60)) $((_uptime%60))
}


#########################
## Functions - Contents management (files, value, pattern matching ...)

# usage: getLastLinesFromN <file path> <line begin>
function getLastLinesFromN() {
  local _source="$1" _lineBegin="$2"

  cat -n "$_source" |awk "\$1 >= $_lineBegin {print}" |sed -e 's/^[ \t]*[0-9][0-9]*[ \t]*//'
}

# usage: getLinesFromNToP <file path> <from line N> <line begin> <line end>
function getLinesFromNToP() {
  local _source="$1" _lineBegin="$2" _lineEnd="$3" _sourceLineCount
  _sourceLineCount=$( wc -l <"$_source" )

  tail -n $((_sourceLineCount - _lineBegin + 1)) "$_source" |head -n $((_lineEnd - _lineBegin + 1))
}

# usage: getURLContents <url> <destination file> [<user agent>]
function getURLContents() {
  local _url="$1" _output="$2"
  local _userAgent="${3:-Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:77.0) Gecko/20100101 Firefox/77.0}"

  writeMessage "Getting contents of URL '$_url', with user-agent='$_userAgent', and dumping it to '$_output'"
  ! wget --user-agent="$_userAgent" -q "$_url" -O "$_output" && warning "Error while getting contents of URL '$_url'" && return 1
  info "Got contents of URL '$_url' with success"
  return 0
}

# usage: isNumber <string>
# Returns true if specified string matches a number, false otherwise.
function isNumber() {
  [[ "$1" =~ ^[[:digit:]]+$ ]]
}

# usage: isCompoundedNumber <string>
# Returns true if it is a single number OR a compounded number.
function isCompoundedNumber() {
  [[ "$1" =~ ^[[:digit:]]+-*[0-9]*$ ]]
}

# usage: matchesOneOf <element to check> <patterns>
function matchesOneOf() {
  local _element="$1"
  shift
  local _patterns=("$@")

  for pattern in "${_patterns[@]}"; do
    [[ "$_element" =~ $pattern ]] && return 0
  done

  return 1
}

# Usage: removeAllSpecifiedPartsFromString <string> <parts> [<case-insensitive>]
#  <string>           string to manage (can be a [file]Name/Label or anything else)
#  <parts>            regular expressions separated by | of parts to remove
#  <case-insensitive> activate case insensitivity (0 by default)
# Returns the formatted name.
function removeAllSpecifiedPartsFromString() {
  local _string="$1" _filters="$2" _caseInsensitive="${3:-0}" _sedOptions="g"
  [ "$_caseInsensitive" -eq 1 ] && _sedOptions="i$_sedOptions"

  # Removes label's part exactly matching.
  while IFS= read -r -d '|' filterPattern; do
    [ -z "$filterPattern" ] && continue
    _string=$( sed -E "s/$filterPattern//$_sedOptions;" <<< "$_string" )
  done <<< "$_filters|"

  # Returns the formatted [file]Name/Label.
  echo "$_string"
}

# Usage: extractNumberSequence <string>
#  <string>: string from which to extract number sequence
# Returns the found number sequence.
function extractNumberSequence() {
  local _string="$1" _result=""

  # shellcheck disable=SC2001
  _result=$( sed -e 's/^[^0-9]*\([sS]*[0-9][0-9]*\)[ \t]*[-aàep&][ \te0]*\([1-9][0-9]*\)[^0-9]*$/\1-\2/ig;' <<< "$_string" \
            |sed -e 's/^[^0-9]*\([0-9]-*[0-9]*\)[^0-9]*$/\1/g;')

  [ "$BSC_DEBUG_UTILITIES" -eq 1 ] && printf "Extracted number sequence from name '%b' => '%b'" "$_string" "$_result" >&2

  # Returns the number sequence.
  echo "$_result"
}

#########################
## Functions - PID File Feature

# usage: writePIDFile <pid file> <process name>
function writePIDFile() {
  local _pidFile="$1" _processName="$2"

  # Safe-guard.
  if [ -f "$_pidFile" ]; then
    errorMessage "PID file '$_pidFile' already exists." -1
    return $BSC_ERROR_PID_FILE
  fi

  ! updateStructure "$( dirname "$_pidFile" )" && errorMessage "Unable to create parent directory of PID file '$_pidFile'." $BSC_ERROR_ENVIRONMENT

  echo "processName=$_processName" > "$_pidFile"
  echo "pid=$$" >> "$_pidFile"
  info "Written PID '$$' of process '$_processName' in file '$_pidFile'."
}

# usage: deletePIDFile <pid file>
function deletePIDFile() {
  local _pidFile="$1"

  info "Removing PID file '$_pidFile'"
  rm -f "$_pidFile"
}

# usage: doExtractInfoFromPIDFile <pid file> <pid|processName>
# N.B.: must NOT be called directly.
function doExtractInfoFromPIDFile() {
  local _pidFile="$1" _info="$2" _pidToCheck

  # Checks if PID file exists, otherwise regard process as NOT running.
  [ ! -f "$_pidFile" ] && errorMessage "PID file '$_pidFile' not found." -1 && return $BSC_ERROR_PID_FILE

  # Gets PID from file, and ensures it is defined.
  _pidToCheck=$( grep -e "^$_info=" "$_pidFile" |head -n 1 |sed -e 's/^[^=]*=//' )
  [ -z "$_pidToCheck" ] && errorMessage "PID file '$_pidFile' empty." -1 && return $BSC_ERROR_PID_FILE

  # Writes it.
  echo "$_pidToCheck" && return 0
}

# usage: getPIDFromFile <pid file>
function getPIDFromFile() {
  doExtractInfoFromPIDFile "$1" "pid"
}

# usage: getProcessNameFromFile <pid file>
function getProcessNameFromFile() {
  doExtractInfoFromPIDFile "$1" "processName"
}

# usage: isRunningProcess <pid file>
function isRunningProcess() {
  local _pidFile="$1" _pidToCheck _processName

  # Checks if PID file exists, otherwise regard process as NOT running.
  [ ! -f "$_pidFile" ] && info "PID file '$_pidFile' does not exist (anymore). System will consider process as NOT running." && return 1

  # Extracts the PID, and process name.
  _pidToCheck=$( getPIDFromFile "$_pidFile" ) || return 1
  _processName=$( getProcessNameFromFile "$_pidFile" ) || return 1

  # Special hacks to help users. Some application uses symbolic links, and so running process name
  #  won't be the same than launched process name. For instance it is the case with SoX (in particular
  #  when source code has been compiled).
  # This is the list of "synonyms":
  #  - sox/play/rec/lt-sox
  [ "$_processName" = "play" ] && _processName="$_processName|sox"
  [ "$_processName" = "rec" ] && _processName="$_processName|sox"

  # Checks if a process with specified PID is running.
  info "Checking running process, PID=$_pidToCheck, process=$_processName."
  [ "$( pgrep -f "$_processName" |grep -wc "$_pidToCheck" )" -eq 1 ] && return 0

  # It is not the case, informs and deletes the PID file.
  deletePIDFile "$_pidFile"
  info "process is dead but pid file still exists. Deleted it."
  return 1
}

# usage: checkAllProcessFromPIDFiles [<pid directory>]
# Checks all existing PID files, checks if corresponding process are still running,
#  and deletes PID files if it is not the case.
function checkAllProcessFromPIDFiles() {
  local _pidDir="${1:-$BSC_PID_DIR}"

  info "Check any existing PID file in '$_pidDir' (and clean if corresponding process is no more running)."
  # For any existing PID file.
  while IFS= read -r -d '' pidFile; do
    # Checks if there is still a process with this name and this PID,
    #  if it is not the case, the PID file will be removed.
    isRunningProcess "$pidFile"
  done < <(find "$_pidDir" -type f -iname "*.pid" -print0)
}


#########################
## Functions - Daemon Feature

# usage: _startProcess <pid file> <process name> <options>
# options MUST be an array containing any count of elements
function _startProcess() {
  local _pidFile="$1"
  shift
  local _processName="$1"
  shift
  local _options=("$@")

  ## Safe-guard: ensure Binary can be executed.
  BSC_MODE_CHECK_CONFIG=1 checkBin "$_processName" || errorMessage "Safe-guard: '$_processName' tool not found; aborting replacement of this shell with '$_processName' tool, and options: '${_options[*]}'"

  ## Writes the PID file.
  writePIDFile "$_pidFile" "$_processName" || return 1

  ## If BSC_LOG_CONSOLE_OFF is not already defined, messages must only be written in log file (no more on console).
  [ -z "$BSC_LOG_CONSOLE_OFF" ] && export BSC_LOG_CONSOLE_OFF=1

  ## Executes the specified command -> such a way the command WILL have the PID written in the file.
  info "Starting background command: $_processName ${_options[*]}"
  exec "$_processName" "${_options[@]}"
}

# usage: _stopProcess <pid file> <process name>
function _stopProcess() {
  local _pidFile="$1"
  local _processName="$2"

  # Safe-guard: ensures PID file exists.
  [ ! -f "$_pidFile" ] && info "PID file '$_pidFile' does not exist. Nothing more to do, to stop process '$_processName'." && return 0

  # Gets the PID.
  pidToStop=$( getPIDFromFile "$_pidFile" ) || errorMessage "No PID found in file '$_pidFile'."

  # Requests stop.
  info "Requesting process stop, PID=$pidToStop, process=$_processName."
  kill -s TERM "$pidToStop" || return 1

  # Waits until process stops, or timeout is reached.
  remainingTime=$BSC_DAEMON_STOP_TIMEOUT
  while [ "$remainingTime" -gt 0 ] && isRunningProcess "$_pidFile"; do
    # Waits 1 second.
    sleep 1
    (( remainingTime-- ))
  done

  # Checks if it is still running, otherwise deletes the PID file ands returns.
  ! isRunningProcess "$_pidFile" && deletePIDFile "$_pidFile" && return 0

  # Destroy the process.
  info "Killing process stop, PID=$pidToStop, process=$_processName."
  kill -s KILL "$pidToStop" || return 1
}

# usage: killChildProcesses <pid> [1]
# 1: toggle defining it is the top hierarchy process (and thus won't be killed).
function killChildProcesses() {
  local _pid="$1" _topProcess="${2:-0}"

  # Manages PID of each child process of THIS process.
  while IFS='' read -r -d '' childProcessPid; do
    # Ensures the child process still exists; it won't be the case of the last launched ps allowing to
    #  get child process ...
    ps -p "$childProcessPid" --no-headers >/dev/null && killChildProcesses "$childProcessPid"
  done < <(ps -o pid --no-headers --ppid "$_pid")

  # Kills the child process if not main one.
  [ "$_topProcess" -eq 0 ] && kill -s HUP "$_pid"
}

# usage: _setUpKillChildTrap <process name>
function _setUpKillChildTrap() {
  export TRAP_processName="$1"

  ## IMPORTANT: when the main process is stopped (or killed), all its child must be stopped too,
  ##  defines some trap to ensure that.
  # When this process receive an EXIT signal, kills all its child processes.
  # N.B.: old system, killing all process of the same process group was causing error like "broken pipe" ...
  trap 'writeMessage "Killing all processes of the group of main process $TRAP_processName"; killChildProcesses $$ 1; exit 0' EXIT
}

# usage: manageDaemon <action> <name> <pid file> <process name> [<logFile> <outputFile> [<options>]]
#   <action> can be one of:
#    - $BSC_DAEMON_ACTION_START   requests start of the Daemon
#    - $BSC_DAEMON_ACTION_STATUS  checks the status of the Daemon
#    - $BSC_DAEMON_ACTION_STOP    stops the Daemon and all its potential child processes
#    - $BSC_DAEMON_ACTION_RUN     (internal) (optional) runs instructions of the Daemon script itself
#    - $BSC_DAEMON_ACTION_DAEMON  (internal) really turns to a daemon
#
#   <name>         name of your Daemon script
#   <pid file>     the PID file to use to manage the process which will be "daemonized"
#   <process name> the name/path of the process to launch (can be a third party tool, or the Daemon script itself)
#   <logFile>      the log file to define with $BSC_LOG_FILE variable (See Logger Feature) in the Daemon process context
#                  only needed if action is $BSC_DAEMON_ACTION_START
#   <outputFile>   the file in which Daemon output will be redirected
#                  only needed if action is $BSC_DAEMON_ACTION_START
#   <options>      Daemon options, MUST be an GNU/Bash array
#                  only needed if action is $BSC_DAEMON_ACTION_DAEMON
#
# Action call flow:
#   Start => (internal) Daemon => (optional)(internal) Run* => Stop
#   At any time, the Status can be requested to get the status of the daemon
#   * the Run action is only used if Daemon script is running itself
#      some instructions instead of launching third party tool
function manageDaemon() {
  local _action="$1" _name="$2" _pidFile="$3" _processName="$4"
  local _logFile="$5" _outputFile="$6"

  case "$_action" in
    $BSC_DAEMON_ACTION_DAEMON)
      # Reads all optional remaining parameters as an options array.
      shift 6
      _options=("$@")

      # If the option is NOT the special one which activates last action "run"; setups trap ensuring
      # children process will be stopped in same time this main process is stopped, otherwise it will
      # setup when managing the run action.
      [[ "${_options[*]}" != "$BSC_DAEMON_OPTION_RUN" ]] && _setUpKillChildTrap "$_processName"

      # Starts the process.
      # N.B.: here we WANT word splitting on $_options, so we don't put quotes.
      _startProcess "$_pidFile" "$_processName" "${_options[@]}"
    ;;

    $BSC_DAEMON_ACTION_START)
      # Ensures it is not already running.
      isRunningProcess "$_pidFile" && writeMessage "$_name is already running." && return 0

      # Starts it, launching this script in daemon mode.
      BSC_LOG_FILE="$_logFile" BSC_LOG_CONSOLE_OFF=${BSC_LOG_CONSOLE_OFF:-1} "$0" "$BSC_DAEMON_OPTION_DAEMON" >>"$_outputFile" &
      writeMessage "Launched $_name."
    ;;

    $BSC_DAEMON_ACTION_STATUS)
      if isRunningProcess "$_pidFile"; then
        writeMessage "$_name is running."
      else
        writeMessage "$_name is NOT running."
      fi
    ;;

    $BSC_DAEMON_ACTION_STOP)
      # Checks if it is running.
      ! isRunningProcess "$_pidFile" && writeMessage "$_name is NOT running." && return 0

      # Stops the process.
      _stopProcess "$_pidFile" "$_processName" || errorMessage "Unable to stop $_name."
      writeMessage "Stopped $_name."
    ;;

    $BSC_DAEMON_ACTION_RUN)
      ## If BSC_LOG_CONSOLE_OFF is not already defined, messages must only be written in log file (no more on console).
      [ -z "$BSC_LOG_CONSOLE_OFF" ] && export BSC_LOG_CONSOLE_OFF=1

      # Setups trap ensuring children process will be stopped in same time this main process is stopped.
      _setUpKillChildTrap "$_processName"
    ;;

    [?])  return 1;;
  esac
}

# usage: daemonUsage <name>
function daemonUsage() {
  local _name="$1"
  echo -e "Usage: $0 -S||-T||-K||-X [-hv]"
  echo -e "-S\tstart $_name daemon"
  echo -e "-T\tstatus $_name daemon"
  echo -e "-K\tstop $_name daemon"
  echo -e "-X\tcheck configuration and quit"
  echo -e "-v\tactivate the verbose mode"
  echo -e "-h\tshow this usage"
  echo -e "\nYou must either start, status or stop the $_name daemon."

  exit $BSC_ERROR_USAGE
}


#########################
## Functions - Third Part PATH feature

# Should not be directly called.
# N.B.: if you need a dedicated function for a not supported tool, please create an issue on scripts-common project.
function _manageThidPartyToolHome() {
  local _toolName="$1" _envVarName="$2" _configKey="$3" _binPathToCheck="$4|"

  # Checks if environment variable is defined.
  if [ -z "${!_envVarName:-}" ]; then
    # Checks if it is defined in configuration file.
    checkAndSetConfig "$_configKey" "$BSC_CONFIG_TYPE_OPTION"
    declare -r toolHome="$BSC_LAST_READ_CONFIG"
    if [ -z "$toolHome" ] || [[ "$toolHome" == "$BSC_CONFIG_NOT_FOUND" ]]; then
      # It is a fatal error but in 'BSC_MODE_CHECK_CONFIG' mode.
      local _errorMessage="You must either configure '$_envVarName' environment variable or '$_configKey' configuration element."
      ! isCheckModeConfigOnly && errorMessage "$_errorMessage" $BSC_ERROR_ENVIRONMENT
      warning "$_errorMessage" && return $BSC_ERROR_ENVIRONMENT
    fi

    # Ensures it exists.
    local _errorMessage=""
    if [ ! -e "$toolHome" ]; then
      _errorMessage="'$_configKey' defined '$toolHome' which does not exist."
    elif [ ! -d "$toolHome" ]; then
      _errorMessage="'$_configKey' defined '$toolHome' which is not a directory."
    fi

    if [ -n "$_errorMessage" ]; then
      # It is a fatal error but in 'BSC_MODE_CHECK_CONFIG' mode.
      ! isCheckModeConfigOnly && errorMessage "$_errorMessage" $BSC_ERROR_CONFIG_VARIOUS
      warning "$_errorMessage" && return $BSC_ERROR_CONFIG_VARIOUS
    fi

    export "$_envVarName"="$toolHome"
  fi

  # Ensures corresponding tool binaries are found in home directory.
  local _errorMessage=""
  while IFS= read -r -d '|' binPathToCheck; do
    local _toolBinPath="${!_envVarName}/$binPathToCheck"
    if [ ! -f "$_toolBinPath" ]; then
      _errorMessage="Unable to find $binPathToCheck binary, ensure '${!_envVarName}' is the home of $_toolName."
      break
    fi
  done <<<"$_binPathToCheck"

  if [ -n "$_errorMessage" ]; then
    # It is a fatal error but in 'BSC_MODE_CHECK_CONFIG' mode.
    ! isCheckModeConfigOnly && errorMessage "$_errorMessage" $BSC_ERROR_CONFIG_VARIOUS
    warning "$_errorMessage" && return $BSC_ERROR_CONFIG_VARIOUS
  fi
}

# For each Third party tool management function:
#  - Checks if corresponding environment variable if defined, set it according
#     to definition in configuration file, with lots of check (exists, directory,
#     contains requested binaries).
#  - If environment is defined (already defined, or defined by this utilities),
#     checks if the requested tools exists.
# If the function returns "ok", you are guarantee to have an environment variable
#  properly defined.

# usage: manageJavaHome
function manageJavaHome() {
  _manageThidPartyToolHome "a Java Development Kit" "JAVA_HOME" "environment.java.home" "bin/java|bin/javac" || return $BSC_ERROR_CONFIG_VARIOUS
  writeMessage "Found: $( "$JAVA_HOME/bin/java" -version 2>&1|head -n 2| sed -e 's/$/ [/;' |tr -d '\n' |sed -e 's/..$/]/' )"
}

# usage: manageAntHome
function manageAntHome() {
  _manageThidPartyToolHome "an installation of Apache Ant" "ANT_HOME" "environment.ant.home" "bin/ant" || return $BSC_ERROR_CONFIG_VARIOUS
  writeMessage "Found: $( "$ANT_HOME/bin/ant" -v 2>&1|head -n 1 )"
}

# usage: manageMavenHome
function manageMavenHome() {
  _manageThidPartyToolHome "an installation of Apache Maven" "M2_HOME" "environment.maven.home" "bin/mvn" || return $BSC_ERROR_CONFIG_VARIOUS
  writeMessage "Found: $( "$M2_HOME/bin/mvn" -v 2>&1|head -n 1 )"
}

#########################
## GNU/Bash compatbility check
# N.B.: now that functions are defined, we can use them.

# GNU/Bash printf Date feature is available since version 4.3
# N.B.: the compatibility mode can be forced on/off with BSC_FORCE_COMPAT_MODE variable.
if isVersionGreater "${BASH_VERSINFO[0]}.${BASH_VERSINFO[1]}" "4.3" 1; then
  declare -r _BSC_COMPAT_DATE_PRINTF=1
  declare -r _BSC_COMPAT_ASSOCIATIVE_ARRAY=1
fi

#########################
## Default variables' values
launchedScriptName="$( basename "$0" )"
declare -r _BSC_DEFAULT_ROOT_DIR="${_BSC_DEFAULT_ROOT_DIR:-${HOME:-/home/$( whoami )}/$launchedScriptName}"
declare -r _BSC_DEFAULT_TMP_DIR="${BSC_TMP_DIR:-/tmp/$( getFormattedDatetime '%Y-%m-%d-%H-%M-%S' )-$launchedScriptName}"
declare -r _BSC_DEFAULT_PID_DIR="$_BSC_DEFAULT_TMP_DIR/_pids"

declare -r _BSC_DEFAULT_LOG_FILE="${_BSC_DEFAULT_LOG_FILE:-$_BSC_DEFAULT_TMP_DIR/logFile.log}"
declare -r _BSC_DEFAULT_CONFIG_FILE="${HOME:-/home/$( whoami )}/.config/${launchedScriptName%[.]*}.conf"
declare -r _BSC_DEFAULT_GLOBAL_CONFIG_FILE="/etc/${launchedScriptName%[.]*}.conf"
declare -r _BSC_DEFAULT_TIME_FILE="$_BSC_DEFAULT_TMP_DIR/timeFile"

declare -r _BSC_DEFAULT_TIME_FORMAT="%Y-%m-%d %H:%M.%S"

declare -r _BSC_DEFAULT_DAEMON_STOP_TIMEOUT=16

updateStructure "$_BSC_DEFAULT_PID_DIR"

#########################
## Global variables
# Defines various directory path, if not already defined by caller.
BSC_ROOT_DIR=${BSC_ROOT_DIR:-$_BSC_DEFAULT_ROOT_DIR}
BSC_TMP_DIR=${BSC_TMP_DIR:-$_BSC_DEFAULT_TMP_DIR}
BSC_PID_DIR=${BSC_PID_DIR:-$_BSC_DEFAULT_PID_DIR}

# Defines various file path, if not already defined by caller.
BSC_LOG_FILE=${BSC_LOG_FILE:-$_BSC_DEFAULT_LOG_FILE}
BSC_CONFIG_FILE=${BSC_CONFIG_FILE:-$_BSC_DEFAULT_CONFIG_FILE}
BSC_GLOBAL_CONFIG_FILE=${BSC_GLOBAL_CONFIG_FILE:-$_BSC_DEFAULT_GLOBAL_CONFIG_FILE}
BSC_TIME_FILE=${BSC_TIME_FILE:-$_BSC_DEFAULT_TIME_FILE}

# Defines the time format used in formatted messages.
BSC_TIME_FORMAT=${BSC_TIME_FORMAT:-$_BSC_DEFAULT_TIME_FORMAT}

# Defines the daemon timeout when requesting its stop, before killing it.
BSC_DAEMON_STOP_TIMEOUT=${BSC_DAEMON_STOP_TIMEOUT:-$_BSC_DEFAULT_DAEMON_STOP_TIMEOUT}

# By default Debug mode is Off.
BSC_DEBUG_UTILITIES=${BSC_DEBUG_UTILITIES:-0}

# By default Verbose mode is Off, it is automatically switched on if Debug mode is On.
BSC_VERBOSE=${BSC_VERBOSE:-$BSC_DEBUG_UTILITIES}

# Defines if configuration check failure must NOT exit the caller script.
# N.B.:
#  - by default it is recommended to get an exit asap of the caller, to avoid
#     working on bad configuration (like bad path for instance)
#  - but it can be very interesting to perform a whole check of configuration to
#     report all error at once (it is the case with -X option of daemon scripts)
BSC_MODE_CHECK_CONFIG=${BSC_MODE_CHECK_CONFIG:-0}
# Defines default BSC_CATEGORY if not already defined.
BSC_CATEGORY=${BSC_CATEGORY:-general}
# By default, system logs messages on console.
BSC_LOG_CONSOLE_OFF=${BSC_LOG_CONSOLE_OFF:-0}

# By default, any error message will totally ends the script.
# This variable allows changing this behaviour (NOT recommended !!!)
BSC_ERROR_MESSAGE_EXITS_SCRIPT=${BSC_ERROR_MESSAGE_EXITS_SCRIPT:-1}
