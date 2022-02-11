#!/usr/bin/env bash
#echo "add max_map_count for elasticsearch"
#chmod u+w /etc/sysctl.conf
#sysctl -w vm.max_map_count=262144
echo "waiting for database to start..."
/wait_mysql_progress.sh
echo "setting up database..."
bin/rake db:setup && bin/rake db:migrate && bin/rake db:migrate RAILS_ENV=test
echo "starting workers..."
rake sneakers:run --trace
echo "starting application server..."
rm -f tmp/pids/server.pid
bin/rails server -b 0.0.0.0 -p "$APPLICATION_PORT"
echo "application server up and running..."