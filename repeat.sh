#!/bin/sh

# valid command line arguments:
#
# specify number of times to repeat command
# -n
# (default is 1 invocation)

# specify sleep delay between invocations
# -s #
# (default is not to sleep at all)


#
# anything after -- will be the command that is invoked

# A typical run might look like this:
# ./repeat.sh -n 3 -s 5 -- date

WHEREAMI=`dirname $0`

WHOAMI=`basename $0`

COUNT=1
SLEEP=0

while getopts n:s: OPT; do
    case $OPT in
        n|+n) COUNT=$OPTARG;;
        s|+s) SLEEP="$OPTARG";;
        *)
        echo "usage: $WHOAMI [+-n count] [+-s seconds] [--] command to invoke ..."
        exit 2
    esac
done
shift `expr $OPTIND - 1`


command=$@
COUNTER=0
while [ $COUNTER -lt $COUNT ]; do
    COUNTER=`expr $COUNTER + 1`
    $command
    sleep $SLEEP
done

exit 0
