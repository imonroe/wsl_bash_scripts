#!/usr/bin/env bash

# Three-fingered Claw Technique
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

echo "Let's set you up a database, guy."
echo "Please enter root user MySQL password!"
echo "Note: password will be hidden when typing"
try read -s rootpasswd

echo "Please enter the NAME of the new MySQL database! (example: database1)"
try read dbname

echo "Please enter the MySQL database CHARACTER SET! (example: latin1, utf8, ...)"
echo "Enter utf8 if you don't know what you are doing. Probably a good choice even if you do know what you're doing"
try read charset

echo "Creating new MySQL database..."
try mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${dbname} /*\!40100 DEFAULT CHARACTER SET ${charset} */;"
echo "Database successfully created!"

echo "Showing existing databases..."
try mysql -uroot -p${rootpasswd} -e "show databases;"
echo ""

echo "Please enter the NAME of the new MySQL database user! (example: user1)"
try read username

echo "Please enter the PASSWORD for the new MySQL database user!"
echo "Note: password will be hidden when typing"
try read -s userpass

echo "Creating new user..."
try mysql -uroot -p${rootpasswd} -e "CREATE USER ${username}@localhost IDENTIFIED BY '${userpass}';"
echo "User successfully created!"
echo ""

echo "Granting ALL privileges on ${dbname} to ${username}!"
try mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO '${username}'@'localhost';"
try mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"

echo "You're good now :)"

exit 0
