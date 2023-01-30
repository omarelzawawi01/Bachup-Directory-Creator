#! /bin/bash

#Remove this comment and replace it with the code specified in the README file
args=("$@")

#check whether the directory exists or not

if [ -d "${args[0]}" ]
then
	echo -n ""
else
	echo "The directory to be backed up, ${args[0]}, does not exist, Terminating. "
	exit
fi

exp='^[1-9]+$'

#check that the time interval and the number of backups is greater than 0
if ! [[ ${args[2]} =~ $exp ]]
then
	echo  "Invalid maximum number of backups, ${args[2]}, Terminating."
	exit
fi	
	
if [[ ${#args[@]} -ne 3 ]]
then
	echo "Invalid number of arguements. Terminating"
	exit
fi

#Check that at the first time the directory was never backedup before, so that in the next iteration it does not overwrite the last version
if ! [ -f "directory-info.last" ]
then
	ls -lR ${args[0]} > directory-info.last
	mkdir -p ${args[1]}
	cp -r -p ${args[0]} ${args[1]}/$(date +"%Y-%m-%d-%H-%M-%S")
	echo "Directory info created, created first backup."
	exit
fi

lastfile=$( < directory-info.last)



numofbackups=(${args[1]}/*)
ls -lR ${args[0]} > directory-info.new
newfile=$( < directory-info.new)

if [ "$lastfile" != "$newfile" ]
then
	echo "Modification" 
	ls -lR ${args[0]} > directory-info.last
	lastfile=$( < directory-info.last)
	#if the maximum number of backups was reached
	if [[ ${#numofbackups[@]} -eq ${args[2]} ]]
	then
		echo "reached maximum number of backups,backup directory to be deleted: ${args[1]}/${numofbackups[0]}"
		rm -r ${numofbackups[0]}
	fi
	cp -r -p ${args[0]} ${args[1]}/$(date +"%Y-%m-%d-%H-%M-%S")
	echo "Created backup: ${args[1]}/$(date +"%Y-%m-%d-%H-%M-%S")"	
else
	echo "no modifiation"
fi



