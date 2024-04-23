#!/bin/bash

USERID=$(id -u)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
echo "please enter db password"
read mention

G="\e[31m]"
R="\e[32m]"
Y="\e[33m]"
N="\e[0m]"

if [ $USERID -ne 0 ]
then
echo "please run this script as root user"
       exit1
else
echo "you are  a super user"
fi


VALIDATE(){
    if [ $1 -ne 0 ]
    then 
    echo -e "$2...$R failure $N "
    else
    echo -e "$2...$G success $N"
    fi
}

dnf install mysql-server -y
VALIDATE $? "Installing mysql"

systemctl enable mysqld
systemctl start mysqld
mysql_secure_installation --set-root-pass $mention



