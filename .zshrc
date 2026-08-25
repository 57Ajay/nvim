# Enable autocomplete and completion
autoload -Uz compinit
compinit

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# History
export HISTSIZE=2000
export SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

# Environment setup
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
if [ -f "$HOME/.local/bin/env" ]; then . "$HOME/.local/bin/env"; fi
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
FNM_PATH="$HOME/.local/share/fnm"
[ -d "$FNM_PATH" ] && export PATH="$FNM_PATH:$PATH" && eval "$(fnm env)"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -d "$HOME/.deno" ] && export DENO_INSTALL="$HOME/.deno" && export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$PATH:/opt/zig"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT="cabswale-ai"
export GOOGLE_CLOUD_LOCATION="asia-south1"

export HELIX_RUNTIME=$HOME/.config/helix/runtime

# Aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1)"'
alias sudoc='sudo docker'
alias f='rg --files --hidden --follow --glob "!.git/*" | fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
alias ff='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
alias fdf='find . -type d | fzf'
alias fh='history | fzf'
alias frg="rg --color=always --line-number . | fzf --ansi --preview 'bat --style=numbers --color=always --line-range :500 {1}' | cut -d':' -f1,2 | xargs -r nvim"
alias fd=fdfind
alias clip="nohup ~/clip.sh &"

alias dt='date "+%Y-%m-%d %H:%M:%S"'

# nuke node_modules dir from jsts dir
alias nuke_modules='fd node_modules --type d -x rm -rf {}'

# Functions
P() {
    local base_dir="$HOME/Projects"
    local target_dir

    if [ $# -eq 0 ]; then
        target_dir="$base_dir"
    elif [ $# -eq 1 ]; then
        case "$1" in
            rs|py|zig|c|cpp|go|jsts|mult)
                target_dir="$base_dir/$1"
                ;;
            *)
                print -u2 "Error: Unknown project type '$1'."
                print -u2 "Usage: P [rs|py|zig|c|cpp|go|jsts|mult]"
                return 1
                ;;
        esac
    else
        print -u2 "Error: Too many arguments."
        print -u2 "Usage: P [rs|py|zig|c|cpp|go|jsts|mult]"
        return 1
    fi

    if [ -d "$target_dir" ]; then
        cd "$target_dir"
    else
        print -u2 "Error: Directory not found: $target_dir"
        return 1
    fi
}

killp() {
  pid=$(sudo lsof -t -i :"$1")
  if [[ -n "$pid" ]]; then
    echo "Trying graceful shutdown (SIGTERM) on port $1 (pid: $pid)..."
    sudo kill "$pid"
    sleep 2
    if ps -p "$pid" > /dev/null; then
      echo "Still alive. Forcing shutdown (SIGKILL)..."
      sudo kill -9 "$pid"
    else
      echo "Process terminated gracefully."
    fi
  else
    echo "No process found on port $1."
  fi
}


# just nuke it:
nuke() {
  local name="$1"
  local path="${2:-.}"

  if [[ "$name" == "-d" ]]; then
    # Shift the args to get actual dir name
    shift
    name="$1"
    path="${2:-.}"
    fd --type d --exact-depth 1 --exact "$name" "$path" -x rm -rf {}
  else
    fd --type f --exact "$name" "$path" -x rm -f {}
  fi
}

ZSH_THEME="half-life"
source ~/.oh-my-zsh/oh-my-zsh.sh


# bun completions
[ -s "/home/ajay57/.bun/_bun" ] && source "/home/ajay57/.bun/_bun"
alias bat="batcat"

#helix
export PATH="$PATH:/usr/local/helix"


alias ls='eza --icons'
alias ll='eza -la --icons --git'
alias la='eza -a --icons'
alias lt='eza --tree --icons'
alias cat='bat'
alias hstop='herdr server stop'
alias fixshift='sudo systemctl start keyd'
alias resetshift='sudo systemctl stop keyd'
clear() { printf '\n%.0s' $(seq "$(tput lines)"); tput cup 0 0; }
