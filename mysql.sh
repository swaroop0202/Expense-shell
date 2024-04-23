#!/bin/bash

USERID=$(id -u)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=date +%F-%H-%M-%S
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log