# Backup Directory Creator

This application was designed to create a backup directory of a directory specified by the user. It is really effective as it can be kept running in the background while the user can carry on with his tasks and this application will take care of itself.

This application does not need any input from the user after the initial setup, it can run in the background after that.

This application works through the terminal so it is really simple to operate.
This application is split into two modes of operation. The first one is directly through the terminal by running the script in a normal fashion, the second part is done using a cron job.

# First Method

### Mode of Operation

This application works by creating a backup directory of the specified directory, it creates a backup directory as a start, then it checks every time interval, which is also sprecified by the user, if there was any modification to the original directory. If there isn't any, then the application will continue and check again at the next time interval. If there was modification, then the application will create a new backup directory with the current date and time.

The user specifies which directory to backup, the name of the backup directory, time interval between checks and the number of backup directories to be made.

In case the limit number of backup directories was reached, the least recent backup directory will be deleted to make room for the most recent one, this way we maintain the number of backup directories.

### Installation

You only need to install make on your PC so that you can operate through a makefile.
```bash
sudo apt install make
```

### Usage

1.	In this current directory, the is a Makefile, which has 			preinstalled code, make changes to this file at your own risk, so you do not need to enter anything inside the MakeFile, we will operate through the Terminal only.
2.	Also in this directory, there is an .sh file, this file contains the coded algorithm by which this application operates, you must not alter this file by any means.

### How can we use it.

We first open the terminal, then go to the folder where the Makefile, .sh file, and the directory we want to backup.
In the terminal we will write: 
make in1 in2 in3 in4
The four inputs are:
1.	dir, this is the directory we want to backup.
2.	backupdir, the name of the backup directory.
3.	inttime, the time interval between each modification chech.
4. 	maxback, this is maximum number of backup directories desired.
#### Restrictions:
1.	The first arguement, the original directory, must be present, else it exits the application.
2.	The number of seconds in the time interval and the maximum number of  must be non negative integer, greater than 0


What must be written in the terimal looks something like this, the numbers are just examples:

```bash
make dir=dirname backupdir=backupdirname inttime=4 maxback=4
```
Press enter and then the application will start running in the background.

If you wish to terminate the application simply press ctrl+z
 
 # Second Method
 ### Mode of operation
 At the beginning we discussed the method of using the terminal and running the application in the background, but that was not the most effective manner. We can benefit of having a cronjob running in the background, and you can close the terminal and the application will still run. But this will take a few steps.
 
### How can we use it
 
1. To create this cron job, we first need to redirect to reach the directory of the application, we can get the path of the directory, we open the terminal, enter pwd, this will return the current working directory, we will keep this later later.
 
2. To create a cron job, open the terminal and enter the following command:
```bash
 crontab -e
```
 
3. to create a cronjob that runs every minute
 in this example the path we use, /home/name/Desktop/projectbackup, name of .sh file is 
project.sh, in this example the time interval every minute and the maximum number of backup directories is 3.
```bash
 * * * * * cd /home/name/Desktop/project && ./crontest.sh dir dirbackup 3
```
to save the current cronjob press ctrl+x, then press y to save 
4.  This runs the .sh file but in the backgound.
5.	each astrisk represents a variable, at which the cron job executes, you can visit the link below to be familiar with the way a cron job scheduales its tasks.
https://crontab.guru/#*_*_*_*

### Special operating time interval. 
if the user for example needs to run the job in the 3rd friday of every month.
there is a comment in the code
```bash
#Remove this comment and replace it with the code specified in the README file
```
Insert open the terminal, create a cron job, 5 specifies that it only works on fridays.
```bash
* * * * 5 cd /home/name/Desktop/project && ./crontest.sh dir dirbackup 3
```
Replace the comment specified earlier with the following code.

```bash
current_day="$(date +"%d")"

if [[ $current_day -lt 15 || $current_day -gt 21 ]]
then
	exit
fi
```
## Important Note
The backup directory if created before the running of the terminal the program my delete unwanted files and may not run as it supposed to, so it is important that the backup directory to be specific only to the directory you want to backup and must be initally empty, this is your responsibility.

