#!/bin/bash

USERID=$(id -u)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log


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

dnf module disable nodejs -y
VALIDATE $? "disabling nodejs"

dnf module enable nodejs:20 -y
dnf install nodejs -y
id expense
if [ $? -ne 0 ]
then
useradd expense
else
echo "user alrdy created skipping "
mkdir /app 
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip
cd /app
unzip /tmp/backend.zip
cd /app
npm install
/home/ec2-user/expense-shell/backend.service /etc/systemd/system/backend.service
systemctl daemon-reload
systemctl start backend
systemctl enable backend
dnf install mysql -y
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp@1 < /app/schema/backend.sql

