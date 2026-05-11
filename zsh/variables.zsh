export APP_FOLDER="$HOME/App"
export MYNOTES="$HOME/Documents/Notes" 
export DOTFILES="$(cd "$(dirname "${(%):-%N}")/.." && pwd)"
export DOTFILES_ASSETS="$DOTFILES/assets"

export JAVA_HOME="/usr/lib/jvm/java-1.21.0-openjdk-amd64"
export CATALINA_BASE="$APP_FOLDER/tomcat"
export CATALINA_HOME="$APP_FOLDER/tomcat"

# Java lombok extension
export JDTLS_JVM_ARGS="-javaagent:$HOME/lsp/lombok.jar"

# Golang
export GOPATH=$HOME/go
# Nvim
export EDITOR=nvim

export VISUAL=vi
# NNN
export NNN_TRASH=2

export GREP_COLORS='ms=01;31'

export STARSHIP_CONFIG="$DOTFILES/starship/starship.toml"

export GHOSTTY_RESOURCES_DIR="$DOTFILES/ghostty"


export FZF_DEFAULT_OPTS="--style=minimal
  --layout=reverse
  --color=dark
  --color=fg:-1,fg+:#f9fbff,bg:-1,bg+:#252525
  --color=hl:#f8e081,hl+:#f8e081
  --color=info:#6e6f70,footer:#6e6f70
  --color=marker:#c8a5ff
  --color=pointer:#f16da6:regular
  --color=prompt:#33b1ff,spinner:#08bdba
  --color=border:#353535"

# PATH
path+=("$HOME/.npm-packages/bin")
path+=("$HOME/.local/bin")
path+=('/opt/apache-maven-3.6.3/bin')
path+=("$HOME/App/flutter/bin")
path+=("$GOPATH/bin")
