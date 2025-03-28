#!/bin/bash
ID=$(id -u)
if [ $ID -ne 0 ]
then 
    echo -e "\e[31m ERROR::\e[0m plz use root user"
    exit 1
    else
        echo -e "\e[32m u r a root user"
fi
yum install git -y
if [ $? -ne 0 ]
then 
    echo -e "\e[31m git installation is failed...."
    else 
       echo -e "\e[32m git installation is successful...."
fi