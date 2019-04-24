#!/bin/bash

#specified directory
directory=$1


#verify setup
if  [ -n $(which brew) ] && [ -n $(which az) ] && [ -n $(which git) ] && [ -n $(which node) ]; then
	echo 'Validation of programs installed successful.'
else
	echo 'One or more required programs are not installed..'
	exit 1
fi

#check for directory
if ! [ -d "$directory" ]; then
	mkdir $directory
fi

#create git repository

		mkdir \
			$directory/.docker

   		touch \
    			$directory/.docker/dockerfile \
    			$directory/.docker/dockerup.yaml

	## github
		mkdir \
    			$directory/.github/ISSUE_TEMPLATE \
    			$directory/.github/PULL_REQUEST_TEMPLATE

    		touch \
    			$directory/.github/ISSUE_TEMPLATE/issue-template.md \
    			$directory/.github/PULL_REQUEST_TEMPLATE/pull-request-template.md

    		touch \
    			$directory/.github/CODE-OF-CONDUCT.md \
    			$directory/.github/CONTRIBUTING.md

	## root
    		mkdir \
    			$directory/client \
    			$directory/src \
    			$directory/test

    		touch \
    			$directory/client/.gitkeep \
    			$directory/src/.gitkeep \
    			$directory/test/.gitkeep

   	 	touch \
			$directory/.azureup.yaml \
			$directory/.dockerignore \
			$directory/.editorconfig \
			$directory/.gitignore \
			$directory/.markdownlint.yaml \
			$directory/CHANGELOG.md \
			$directory/LICENSE.txt \
    			$directory/README.md

#git setup for repository
git init
npm init -y

exit 0
