set KITTY_CONFIG ~/.config/kitty/kitty.conf

function kfs # kitty fs port
	kitty @ set-font-size $argv && \
	sed -i "s/\(font_size\s\+\)[0-9]\+\(.\|.[0-9]\+\)\?/\1$argv/" $KITTY_CONFIG
end

function fn
	if [ "$argv" ]
		echo "*font: $argv" | xrdb -override 
	else
		echo 'missing fontname > fn <fontname>'
	end
end

function _set_font_now
	set fontname (awk -F':' '{print $2}' < /tmp/xfontquery | sed 's/^\s*//')
	set fontsize (cat /tmp/xfontsize)
	echo "*font: $fontname:size=$fontsize" | xrdb -override
	if [ ! -d ~/.xconfig  ]
		mkdir ~/.xconfig
	end
	echo $fontname > ~/.xconfig/xfontname
	echo $fontsize > ~/.xconfig/xfontsize
end

function myfont
	if [ -f ~/.xconfig/xfontname ]; and [ -f ~/.xconfig/xfontsize ]
		set fontname (cat ~/.xconfig/xfontname)
		set fontsize (cat ~/.xconfig/xfontsize)
		echo "*font: $fontname:size=$fontsize" | xrdb -override
	else
		echo "use fn and fs first"
	end
end

function fs
	set sizeconf ~/.xconfig/xfontsize
	set faceconf ~/.xconfig/xfontname
	if xrdb -query | grep font: > /tmp/xfontquery
		if echo $argv | grep -E '[5-9]|(1[0-9]?)' > /tmp/xfontsize
			_set_font_now
		else if [ -f $sizeconf ]; and [ (wc $sizeconf -l | cut -d' ' -f1) -eq 1 ]
			set fontsize (cat $sizeconf)
			switch "$argv"
			case 'inc'
				math $fontsize + 1 > /tmp/xfontsize
				_set_font_now
			case 'dec'
				math $fontsize - 1 > /tmp/xfontsize
				_set_font_now
			case '*'
				echo 'use > fs <fontsize>|inc|dec'
				return 1
			end
		end
	else
		echo 'set font name first > fn <fontname>'
		return 1
	end
end
