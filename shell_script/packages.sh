#!/bin/bash/
ID=(uid)
if[ $ID -ne 0 ]
then
    echo"ERROR::plz use root user"
    else
        echo"u r a root user"
fi
for package in $@
do
  yum install list $package
  if [ $? -ne 0 ]
  then
      yum instll $package -y
      else
          echo"$package is already installed"
fi
done