#how do we run a command in shell script?
# we run a command by using a variable assigned to that command

#!/bin/bash
DATE=$(date)

echo "the date and time is:$DATE"
echo "the script started time of execution is :$DATE"