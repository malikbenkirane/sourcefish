# screen wrapper
function screen
    # TODO port: bass source $SOURCMEPATH/screen.sh \; screen $argv
    if [ (count $argv) -eq 0 ]; or [ "$argv" = "ls" ]
	    command screen -ls\
	    | head -n -1 | tail -n +2\
	    | awk -F'.' '{print $2}'\
	    | sed 's/\s*(Attached)/*/' | sed 's/\s*(Detached)//'
    else if [ (count $argv) -eq 1 ]
	    if command screen -rd "$argv"
		    return
	    else
		    echo New screen session
		    command screen -S "$argv"     
	    end
    else
	    command screen $argv
    end
end

# xrdb wrapper
function xrdb
	if echo $argv | grep -query
		command xrdb $argv
	else
		command xrdb $argv
		killall -s USR1 st
	end
end
