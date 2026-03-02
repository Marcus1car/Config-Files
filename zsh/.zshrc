# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Which plugins would you like to load?
plugins=(git colored-man-pages encode64 zsh-autosuggestions)

ZSH_THEME="spaceship"
source $ZSH/oh-my-zsh.sh

# ── spaceship config ─────────────────────────────────────────────────────────

SPACESHIP_PROMPT_ORDER=(
  user dir git exec_time line_sep
  exit_code char
)
SPACESHIP_CHAR_SYMBOL="» "
SPACESHIP_DIR_TRUNC=3
SPACESHIP_GIT_BRANCH_COLOR=075
SPACESHIP_EXIT_CODE_SHOW=true

# ── environment ─────────────────────────────────────────────────────────────

export PATH="$HOME/.local/bin:$PATH"
export PGDATA="$HOME/postgres_data"
export PGHOST="/run/postgresql"
export EDITOR="hx"
export VISUAL="hx"

# ── aliases ──────────────────────────────────────────────────────────────────

alias hx="helix"
alias treea="tree -a"
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'

mkcd() {mkdir -p "$1" && cd "$1" }

# ── history ──────────────────────────────────────────────────────────────────

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
