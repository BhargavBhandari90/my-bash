#! /bin/bash

cd /Applications/MAMP/htdocs/

echo "Enter WordPress site name ( Just a folder name added in htdocs ):"

read site_name

mkdir $site_name &&
cd $site_name &&
wp core download &&
wp config create --dbname=$site_name --dbuser=root --dbpass=root --dbhost=127.0.0.1:8889 &&
wp db create &&
wp core install --url=localhost:8888/$site_name --title=$site_name --admin_user=admin --admin_password=admin --admin_email=admin@test.com

echo "Your site URL is:" $(wp option get siteurl)

echo "Username: admin"
echo "Password: admin"

echo "Do you want to open it on your default browser?(y/n)"

read is_open

if [ $is_open == 'Y' ] ||  [ $is_open == 'y' ]
    then
        echo "Opening site....."
        open $(wp option get siteurl) #xdg-open for ubuntu
fi
