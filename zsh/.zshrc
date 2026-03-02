# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Which plugins would you like to load?
plugins=(git colored-man-pages encode64 zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# ── af-magic theme ────────────────────────────────────────────────

function afmagic_dashes {
  local python_env_dir="${VIRTUAL_ENV:-$CONDA_DEFAULT_ENV}"
  local python_env="${python_env_dir##*/}"

  if [[ -n "$python_env" && "$PS1" = *\(${python_env}\)* ]]; then
    echo $(( COLUMNS - ${#python_env} - 3 ))
  elif [[ -n "$VIRTUAL_ENV_PROMPT" && "$PS1" = *${VIRTUAL_ENV_PROMPT}* ]]; then
    echo $(( COLUMNS - ${#VIRTUAL_ENV_PROMPT} - 3 ))
  else
    echo $COLUMNS
  fi
}

PS1='${FG[237]}${(l.$(afmagic_dashes)..-.)}'$'\n''${FG[032]}%~$(git_prompt_info)$(hg_prompt_info) ${FG[105]}%(!.#.»)%{$reset_color%} '
PS2="%{$fg[red]%}\ %{$reset_color%}"

RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
if (( $+functions[virtualenv_prompt_info] )); then
  RPS1+='$(virtualenv_prompt_info)'
fi
RPS1+=' ${FG[237]}%n@%m%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[075]}(${FG[078]}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="${FG[214]}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${FG[075]})%{$reset_color%}"

ZSH_THEME_HG_PROMPT_PREFIX=" ${FG[075]}(${FG[078]}"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="${FG[214]}*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="${FG[075]})%{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX=" ${FG[075]}["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"

# ── environment ─────────────────────────────────────────────────────────────

export PATH="$HOME/.local/bin:$PATH"
export PGDATA="$HOME/postgres_data"
export PGHOST="/run/postgresql"

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
