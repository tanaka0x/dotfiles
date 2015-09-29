# Created by newuser for 5.0.5
autoload -Uz add-zsh-hook

# alias
alias em='emacs'

# Emacs ライクな操作を有効にする（文字入力中に Ctrl-F,B でカーソル移動など）
# Vi ライクな操作が好みであれば `bindkey -v` とする
bindkey -e

# 自動補完を有効にする
# コマンドの引数やパス名を途中まで入力して <Tab> を押すといい感じに補完してくれる
# 例： `cd path/to/<Tab>`, `ls -<Tab>`
autoload -U compinit; compinit

# <Tab> でパス名の補完候補を表示したあと、
# 続けて <Tab> を押すと候補からパス名を選択できるようになる
# 候補を選ぶには <Tab> か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない


### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors

# gitinfo
autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' formats '
(%s)-[%F{cyan}%b%f]'

zstyle ':vcs_info:*' actionformats '
(%s)-[%F{cyan}%b%f|%a]'

function get_git_stash_count() {
    local COUNT=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
    if [ "$COUNT" -gt 0 ]; then
        ZSH_GIT_STASH_COUNT="stash($COUNT)"
    else
        ZSH_GIT_STASH_COUNT=""
    fi
}

add-zsh-hook precmd get_git_stash_count
add-zsh-hook precmd vcs_info


PROMPT='(%n@%m) [%{$fg[green]%}%~%{$reset_color%}] ${vcs_info_msg_0_} %{$fg[red]%}${ZSH_GIT_STASH_COUNT}%{$reset_color%}
%# '
RPROMPT=''

