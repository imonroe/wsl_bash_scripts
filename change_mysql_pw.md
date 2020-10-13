# Change the MySql root password.

This is tested and works on Ubuntu 18.04 with MySQL 5.7.

If you have different versions you may need to adjust the instructions somewhat.

Adapted from: https://devanswers.co/how-to-reset-mysql-root-password-ubuntu/

`sudo /etc/init.d/mysql stop`

`sudo mkdir /var/run/mysqld && sudo chown mysql /var/run/mysqld`

`sudo mysqld_safe --skip-grant-tables&`

You may need to open another terminal for the following steps.

`sudo mysql --user=root mysql`

`update user set authentication_string=PASSWORD('your_password_here') where user='root';`

`update user set plugin="mysql_native_password" where User='root';`

`flush privileges;`

`exit`

Works for me!


