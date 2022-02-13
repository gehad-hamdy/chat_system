#!/bin/sh
# wait until MySQL is really available
max_counter=20
counter=1
while ! mysql --protocol TCP -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "show databases;" > /dev/null 2>&1; do
    sleep 1
    # shellcheck disable=SC2006
    # shellcheck disable=SC2003
    counter=`expr $counter + 1`
    if [ "$counter" -gt $max_counter ]; then
        >&2 echo "We have been waiting for MySQL too long already; failing."
        exit 1
    fi;
done