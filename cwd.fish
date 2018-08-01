set holder ~/hot/cwd

function cwd
	if [ -f $holder ]
		set -x CWD (cat $holder)
		pushd $CWD
		echo $CWD
	else
		echo no current working dir
	end
end

function swd
	if [ "$argv" ]
		pushd $argv
	end
	echo $PWD > $holder
	echo working dir set
end
