#!/usr/bin/env bash

# Three-fingered Claw Technique
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

# preserve our current working directory
CWD=$PWD
echo "Your current working directory is: ${CWD}"

echo "Ready to set up a new site for you, buddy."
echo -e '\n\n'
echo "What should be the hostname of the site? e.g., [hostname].lvh.me ?"
try read HOSTNAME

echo -e '\n\n'
echo "Sweet.  What is the directory where the files live? Should be an absolute linux path, e.g., /mnt/c/Users/ian/code/[web root]? (no trailing slash)"
try read DOCROOT

try cp template.conf ${HOSTNAME}.conf

try sed -i "s/{{hostname}}/${HOSTNAME}/g" ${HOSTNAME}.conf
# Paths have slashes, and that means we need to change the delimiter in the sed command.
try sed -i "s,{{docroot}},${DOCROOT},g" ${HOSTNAME}.conf

try cd /etc/apache2/sites-enabled && sudo ln -s ${CWD}/${HOSTNAME}.conf ${HOSTNAME}.conf
try cd ${CWD}
# try sudo ln -s ${HOSTNAME}.conf /etc/apache2/sites-enabled/${HOSTNAME}.conf
try sudo service apache2 restart

echo "You want to go ahead and set up a database while you're at it? (y/n)?"
read CREATEDB
if [ $CREATEDB == 'y' ]
then
	try ./create_database.sh
fi

echo -e 'You should be all good, my friend.\n\n'
echo "Visit your new site at: http://${HOSTNAME}.lvh.me"

exit 0


