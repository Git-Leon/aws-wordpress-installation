#!/bin/bash
source ~/environment/aws-wordpress-installation/import_utils.sh
#source ./import_utils.sh

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
 echo "Create a MySQL database for the WordPress site to use."
 echo "To do this, run the following command, replacing 'wordpress_db' with a name for the new database, for example, 'mysite'."
 echo "Be sure to save this database name in a secure location for later use."
 echo "CREATE DATABASE wordpress_db;"
 promptUser
 
}

printHowToCreateDatabaseUser() {
	echo "Create a MySQL user for the WordPress site to use."
	echo "To do this, run the following command, replacing 'wordpress_user' with the users name and replacing 'my_password' with a password for the user"
	echo "GRANT ALL PRIVILEGES ON *.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'my_password';"
	promptUser
}

startMySQLAsRoot() {
	printHowToCreateDatabase
	printHowToCreateDatabaseUser
	sudo mysql -uroot -p
}

printRenameAndSetConfiguration() {
	echo -e "\nStep 3, Part 1 - rename \`wp-config-sample.php\` to \`wp-config.php\`"
	promptUser
	
	echo -e "\nStep 3, Part 2 - Configure the \`wp-config.php\` file for the WordPress website before continuing."
	promptUser
	
	echo -e "\nStep 3, Part 3 - Edit \`wp-config.php\` file to open it in the editor, replace the following values, and then save and close the file."
	promptUser
	
	echo -e "\tReplace \`database_name_here\` with the name of the MySQL database that you created earlier."
	promptUser
	
	echo -e "\tReplace \`username_here\` with the name of the MySQL user that you created earlier."
	promptUser
	
	echo -e "\tReplace \`password_here\` with the password for the MySQL user that you created earlier."
	promptUser
}

printSetWordPressWebsiteLanguage() {
  echo -e "\nStep 3, Part 4 - preview application "
  promptUser
  
  echo -e "\nStep 3, Part 5 - pop out application into new window"
  promptUser

  echo -e "\nStep 3, Part 6 - Set the WordPress website's language, user name, password, and other settings."
  echo "add /wordpress/ to end of existing URL in application preview."
  echo "WordPress > Installation webpage is displayed."
  echo -e "Using the username and password of the MySQL user that you set earlier,\n\tfill out 'Information Needed' section."
  promptUser
}

printNextStep() {
  printRenameAndSetConfiguration
  printSetWordPressWebsiteLanguage
  echo -e "continue by executing \`publish-wordpress-to-web.sh\` file."
}

execute() {
	echo -e "\nStep 1, Part 1 - updating with latest security"
	if promptUser $1; then updateSecurity; fi

	echo -e "\nStep 1, Part 2 - installing Apache HTTP Server"
	if promptUser $1; then installApacheServer; fi

	echo -e "\nStep 1, Part 3 - installing PHP"
	if promptUser $1; then installPHP; fi

	echo -e "\nStep 1, Part 4 - installing SQL"
	if promptUser $1; then installSQL; fi

	echo -e "\nStep 1, Part 5A - starting apache server"
	if promptUser $1; then startApacheServer; fi

	echo -e "\nStep 1, Part 5B - checking server run-status"
	if promptUser $1; then checkServerRunStatus; fi

	echo -e "\nStep 1, Part 6A - starting MySQL"
	if promptUser $1; then startMySQL; fi

	echo -e "\nStep 1, Part 6B - checking server"
	if promptUser $1; then checkMySQLStatus; fi

	echo -e "\nStep 1, Part 7 - downloading wordpress"
	if promptUser $1; then downloadWordPress; fi

	echo -e "\nStep 1, Part 8 - installing wordpressing"
	if promptUser $1; then installWordPress; fi

	echo -e "\nStep 2, Part 1 and 2 - beginning MySQL setup"
	if promptUser $1; then setUpMySQL; fi

	echo -e "\nStep 2, Part 3 - starting mysql as root user"
	if promptUser $1; then startMySQLAsRoot; fi

	printNextStep
}


execute
