export APP_FOLDER="$HOME/App"

export JAVA_HOME="/usr/lib/jvm/java-1.21.0-openjdk-amd64"
export CATALINA_BASE="$APP_FOLDER/tomcat"
export CATALINA_HOME="$APP_FOLDER/tomcat"
# Java lombok extension
export JDTLS_JVM_ARGS="-javaagent:$HOME/lsp/jdtls/lombok.jar"
# Golang
export GOPATH=$HOME/go
# Nvim
export EDITOR=nvim
# NNN
export NNN_TRASH=2

export GREP_COLORS='ms=01;31'
# PATH
path+=("$HOME/.npm-packages/bin")
path+=('/opt/apache-maven-3.6.3/bin')
export PATH
