#!/bin/bash

# start node function
start()
{
	filename=$1

	# conditional to see if required programs are installed
	if  [ -z $(which node) ]; then
		echo 'Required programs currently not installed. Running installer...'
		./linux-setup.sh
	fi

	if [ -e $filename ]; then
		node $filename
	else
		echo 'File does not exist'
		exit 1
	fi
}

# stop function
stop()
{

}

# running start or stop
actions=$1
$actions $2


exit 0
