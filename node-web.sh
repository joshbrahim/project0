#!/bin/bash

#conditional to see if node is installed
if  [ -z $(which node) ]; then
	echo 'Node is not installed.'
	exit 1
fi

# start node function
start()
{
	dirname=$1

	if ! [ -d $dirname ]; then
		echo 'Directory does not exist'
		exit 1
	fi

	#checking for start in json
	cd $dirname
        result=$(cat package.json | grep -E 'start')
        if [ -z "$result" ]; then
                echo 'Invalid start'
                exit 1
        fi

	npm start
}

# stop function
stop()
{
	dirname=$1

	if ! [ -d $dirname ]; then
                echo 'Directory does not exist'
                exit 1
        fi

        #checking for stop in json
        cd $dirname
        result=$(cat package.json | grep -E 'stop')
        if [ -z "$result" ]; then
                echo 'Invalid stop'
                exit 1
        fi
	npm stop
}

actions=$1

# running start or stop
case $actions in
	"start")
		start $2
	;;
	"stop")
		stop $2
	;;
*)
	echo 'Invalid action.'
	exit 1
esac


exit 0
