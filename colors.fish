# TODO clean up (names, abstract and reduce platform dependency)

function colors  # set colors for kitty the terminal emulator
	# allow_remote control should be set to yes
	if test (count $argv) -eq 1
		# TODO argv first match completion
		set scheme $argv
	else
		set scheme \
		(ag -l ~/hot/xcolors/kitty -g '' | fzf | tee /tmp/kitty-colors)
	end
	set kitty_config ~/.config/kitty/kitty.conf
	if test -n "$scheme"
		set n (wc -l < $scheme)
		set x (cat $scheme | sed 's/\s\+/=/')
		kitty @ set-colors $x
		sed "\$s;include .*;include $scheme;" -i $kitty_config
		if test -f /tmp/kitty-colors
			mv /tmp/kitty-colors ~/.xconfig/kitty-colors
		end
	else
		return 1
	end
end

function xcolors # set colors for any terminal that reads xresources
	xrdb -override (ag -l ~/hot/xcolors/ -g '' | fzf | tee /tmp/xcolors)
	cp /tmp/xcolors ~/.xconfig/xcolors
end

alias gruv colors
alias colo colors

function vimcolors
	if grep 'colo \w\+$' ~/.vimcolors > /dev/null
		if [ "$argv" ]
			sed 's/colo \w\+$/colo '"$argv/" ~/.vimcolors -i
			echo colorscheme has been modified, source ~/.vimcolors to see the effect
		end
	else
		echo "colo $argv" > ~/.vimcolors
	end
end
