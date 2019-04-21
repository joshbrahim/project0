#!/bin/bash

#verify linux setup
cd ~

if  [ -n $(which brew) ] && [ -n $(which az) ] && [ -n $(which git) ] && [ -n $(which node) ]; then
	echo 'Validation of programs installed successful.'
	
	#create git repository
		mkdir -p \
			git/.docker

   		touch \
    			git/.docker/dockerfile \
    			git/.docker/dockerup.yaml

	## github
		mkdir -p \
    			git/.github/ISSUE_TEMPLATE \
    			git/.github/PULL_REQUEST_TEMPLATE

    		touch \
    			git/.github/ISSUE_TEMPLATE/issue-template.md \
    			git/.github/PULL_REQUEST_TEMPLATE/pull-request-template.md

    		touch \
    			git/.github/CODE-OF-CONDUCT.md \
    			git/.github/CONTRIBUTING.md

	## root
    		mkdir \
    			git/client \
    			git/src \
    			git/test

    		touch \
    			git/client/.gitkeep \
    			git/src/.gitkeep \
    			git/test/.gitkeep

   	 	touch \
			git/.azureup.yaml \
			git/.dockerignore \
			git/.editorconfig \
			git/.gitignore \
			git/.markdownlint.yaml \
			git/CHANGELOG.md \
			git/LICENSE.txt \
    			git/README.md
	else
	echo 'One or more required programs are not installed.Running installers...'
	sh ./linux-setup.sh
	echo 'Installers ran.'
fi

exit 0
