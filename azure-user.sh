#!/bin/bash

username=$1

#step 1 create user function here
create()
{
	userdisplayname=$1
	DOMAIN=jbrahim385gmail.onmicrosoft.com
	userprincipalname=$userdisplayname@$DOMAIN
	random=testpassword
	usersubscription=$2

	# look at userprincipalname and match it to entry
	result=$(az ad user list --query [].userPrincipalname | grep -E /$userdisplayname/)

	# if no user is found,then create user
	if [ -n $result ]; then
		az ad user create \
		--display-name $userdisplayname --user-principal-name $userprincipalname \
		--force-change-password-next-login --password $random \
		--subscription $usersubscription
	else
		echo 'This user already exists.'
		exit 1
	fi
}


# step 2 assign function here
assign()
{
	action=$1
	username=$2
	role=$3

	result=$(az ad user list --query [].userPrincipalname | grep -E /$username/)

	# conditional for an invalid action
	if [ $action != "create" ] && [ $action != "delete" ]; then
		echo 'This is not a valid action' 
		exit 1
	fi

	# if user does not exist
	if [ -n $result ]; then
        	echo 'This user does not exist.'
		exit 1
	fi

	# if the role name entered is not valid
	if [ $role != "reader" ] && [ $role != "contributor" ]; then
		echo 'This is not a valid role.'
	fi

	# assignment action
	az role assignment $action --assigner $username --role $role
}

# step 3 delete function here
delete()
{
	userprincipalname=$1

	result=$(az ad user list --query [].userPrincipalname | grep -E /$userprincipalname\)

	if [ -z $result ]; then
		echo 'This user does not exist.'
		exit 1
	fi

	admin=$(az role assignment list \
	--include-classic-administrators \
	--query "[?id=='NA(classic admins)'].principalName" | grep -E $userprincipalname)

	if ! [ -z $admin ]; then
        	echo 'Action permission denied.'
        	exit 1
	fi

	# delete user action
	az ad user delete --upn-or-object-id $userprincipalname
}


# login to az ad script
az login -u $username

admin =$(az role assignment list --include-classic-administrators \
	--query "[?id=='NA(classic admins)'].principalName" | grep -E $userprincipalname)

	# if user is an admin, can do actions
	if ! [ -z $admin ]; then
		# calling the functions
		actions=$2
		$actions $3 $4 $5
	else
		echo 'Action permission denied.'
		exit 1
	fi

exit 0
