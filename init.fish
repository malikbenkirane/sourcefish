# this should be sourced from $HOME/.config/fish/config.fish

# aliases
alias python python3
alias mcee '/home/void/recess/devel/mcee/venv/bin/python /home/void/recess/devel/mcee/scli.py'
alias mc mcee
alias mcl 'mc | less'
alias mcf 'mc | fzf'
alias mcg 'mc | grep'
alias mg mcg
alias mp 'mc pick'
# alias m-4 'mc | tail -4'
alias scr screen
alias e $EDITOR
alias accents 'e --clean -R ~/hot/accents.fr.txt -c ":set clipboard=unnamedplus"'

set -x SOURCMEPATH ~/.local/sourceme  # export sourceme path 
set load wrap colors fonts utils cwd

# loads
#
# wrap.fish    # wrapped commands
# colors.fish  # colors utilities
# fonts.fish   # fontfaces utilities
# utils.fish   # miscelleneaous
# cwd.fish     # setting a current working directory
#
# FIXME fix script history_hack.fish

for fishscript in $load
	source $SOURCMEPATH/fish/$fishscript.fish
end

# colors configuration for kitty the terminal emulator (requires colors.fish)
# if test $TERM = 'xterm-kitty'; and test -f ~/.xconfig/kitty-colors
# 	colors (cat ~/.xconfig/kitty-colors)
# end
