#!/bin/bash

username=$1

#step 1 create user function here
create()
{
	#variables for creating
	userdisplayname=$1
	DOMAIN=wookiemonster385gmail.onmicrosoft.com
	userprincipalname=$userdisplayname@$DOMAIN
	pass=testpassword123!
	usersubscription=$2

	# look at array of names and match it to entry
	result=$(az ad user list --query [].userPrincipalName | grep -E /$userprincipalname/)

	if [ -n "$result" ]; then
	echo 'This user already exists'
	exit 1
	fi

	# if no user is found,then create user
	if [ -z "$result" ]; then
		az ad user create \
		--display-name $userdisplayname --user-principal-name $userprincipalname \
		--force-change-password-next-login --password $pass \
		--subscription $usersubscription
		echo 'User created.'
	fi
}


# step 2 assign function here
assign()
{
	dusername=$1
	username=$dusername@wookiemonster385gmail.onmicrosoft.com
	action=$2
	role=$3

	name=$(az ad user list --query [].userPrincipalname | grep -E /$username/)

	# if user does not exist
	if [ -z "$name" ]; then
        	echo 'This user does not exist.'
		exit 1
	fi

	# if the role name entered is not valid
	if [ $role != "reader" ] && [ $role != "contributor" ]; then
		echo 'This is not a valid role.'
	fi

	# assignment action
	az role assignment $action --assignee $username --role $role
}

# step 3 delete function here
delete()
{
	username=$1
	userprincipalname=$username@wookiemonster385gmail.onmicrosoft.com

	name=$(az ad user list --query [].userPrincipalname | grep -E $userprincipalname)

	if [ -z "$name" ]; then
		echo 'This user does not exist.'
		exit 1
	fi

	#checks if user is admin
	admin=$(az role assignment list \
	--include-classic-administrators \
	--query "[?id=='NA(classic admins)'].principalName" | grep -E $userprincipalname)

	if ! [ -z "$admin" ]; then
        	echo 'Action permission denied.'
        	exit 1
	fi

	# delete user action
	az ad user delete --upn-or-object-id $userprincipalname
}

# checks for an admin
admin=$(az role assignment list --include-classic-administrators --query \
	 "[?id=='NA(classic admins)'].principalName" | grep -E $username)

# if user is an admin, can do actions
if [ -n "$admin" ]; then
	echo 'Action permission granted.'
else
	echo 'Action permission denied.'
	exit 1
fi

# calling the functions
actions=$2
$actions $3 $4 $5

exit 0
