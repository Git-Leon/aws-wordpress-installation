#!/bin/bash
#source ~/environment/aws-wordpress-installation/import_utils.sh
source ./import_utils.sh

updateSecurity() {
  sudo yum -y update
}


installApacheServer() {
  sudo yum install -y httpd24
}


installPHP() {
  sudo yum install -y php56
}

installSQL() {
  sudo yum install -y mysql-server
}

startApacheServer() {
  sudo service httpd start
}

checkServerRunStatus() {
  sudo service httpd status
}

startMySQL() {
  sudo service mysqld start
}

checkMySQLStatus() {
  sudo service mysqld status
}

downloadWordPress() {
	wget http://wordpress.org/latest.tar.gz
	cd /home/ec2-user/environment/wordpress/
}

installWordPress() {
	tar -xzvf latest.tar.gz
}

setUpMySQL() {
	sudo mysql_secure_installation
}

printHowToCreateDatabase() {
 echo Create a MySQL database for the WordPress site to use.
 echo To do this, run the following command, replacing \"my_db_name\" with a name for the new database, for example, \"mysite\".
 echo Be sure to save this database name in a secure location for later use.
 echo CREATE DATABASE \`my_db_name\`;
}

printHowToCreateDatabaseUser() {
	echo Create a MySQL user for the WordPress site to use.
	echo To do this, run the following command, replacing \"my_user_name\" with the users name and replacing \"my_password\" with a password for the user
	echo GRANT ALL PRIVILEGES ON *.* TO \'my_user_name\'@\'localhost\' IDENTIFIED BY \'my_password\';
}

startMySQLAsRoot() {
	printHowToCreateDatabase
	printHowToCreateDatabaseUser
	sudo mysql -uroot -p
}

printNextStep() {
	echo Configure the \`wp-config.php\` file for the WordPress website before continuing.
	echo To do this, double-click the \`wp-config.php\` file to open it in the editor, replace the following values, and then save and close the file.
	echo Replace \`database_name_here\` with the name of the MySQL database that you created earlier.
	echo Replace \`username_here\` with the name of the MySQL user that you created earlier.
	echo Replace \`password_here\` with the password for the MySQL user that you created earlier.
}


execute() {
	echo updating with latest security
	if promptUser $1; then updateSecurity; fi

	echo installing Apache HTTP Server
	if promptUser $1; then installApacheServer; fi

	echo installing PHP
	if promptUser $1; then installPHP; fi

	echo installing SQL
	if promptUser $1; then installSQL; fi

	echo starting apache server
	if promptUser $1; then startApacheServer; fi

	echo checking server run-status
	if promptUser $1; then checkServerRunStatus; fi

	echo starting MySQL
	if promptUser $1; then startMySQL; fi

	echo checking server
	if promptUser $1; then checkMySQLStatus; fi

	echo downloading wordpress
	if promptUser $1; then downloadWordPress; fi

	echo installing wordpressing
	if promptUser $1; then installWordPress; fi

	echo beginning MySQL setup
	if promptUser $1; then setUpMySQL; fi

	echo starting mysql as root user
	if promptUser $1; then startMySQLAsRoot; fi

	printNextStep
}


execute
