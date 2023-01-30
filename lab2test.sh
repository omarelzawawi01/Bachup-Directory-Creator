#! /bin/bash
args=("$@")
#Check that the directory exists.
if ! [ -d "${args[0]}" ]
then
	echo -n "The directory to be backed up, ${args[0]}, does not exist, Terminating..."
	rmdir ${args[1]}	
	exit
fi

#Check that time interval and number of backups is integer and greater than 0
exp='^[1-9]+$'
until [[ ${args[2]} =~ $exp ]]
do
	echo  "Invalid time interval, ${args[2]},enter a new time interval, must be an integer value and greater than zero."
	echo -n "New Time interval: "
	read args[2]
done

until [[ ${args[3]} =~ $exp ]]
do
	echo  "Invalid maximum number of backups, ${args[3]}, enter a one, must be an integer value and greater than zero."
	echo -n "New maximum number of backups: "
	read args[3]
done		

	

ls -lR ${args[0]} > directory-info.last
lastfile=$( < directory-info.last)
cp -r -p ${args[0]} ${args[1]}/$(date +"%Y-%m-%d-%H-%M-%S")
array=("${args[1]}/$(date +"%Y-%m-%d-%H-%M-%S")")
rep=1
echo "backup $rep: ${array[0]}"
rep=$((rep - 1))

while true
do
	sleep ${args[2]}
	ls -lR ${args[0]} > directory-info.new
	newfile=$( < directory-info.new)
	if [ "$lastfile" != "$newfile" ]
	then
		echo "Modification"
		rep=$((rep + 1))
		#update the last directory status
		ls -lR ${args[0]} > directory-info.last
		lastfile=$( < directory-info.last)
		if [[ $rep -eq ${args[3]} ]]
		then
			echo "reached maximum number of backups,backup directory to be deleted: ${array[0]} "
			#We must delete the least recent backup directory to make room for the new backup directory
			rm -r ${array[0]}
			unset array[0]
			array=("${array[@]}")
			rep=$((rep - 1))
			
		else
			echo "modified $rep"
		fi
		#add the backup directory and add its name to the array of backups
		cp -r -p ${args[0]} ${args[1]}/$(date +"%Y-%m-%d-%H-%M-%S")
		array+=( "${args[1]}/$(date +"%Y-%m-%d-%H-%M-%S")" )
		echo "Created backup: ${array[$rep]}"	
	else
		echo "no modifiation"
	fi
done

