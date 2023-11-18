#! /bin/bash

echo "Enter your Fresh WordPress site name ( Just a folder name added in htdocs ):"

read site_name

echo "Removing existing plugins & themes..."

rm -rf /Applications/MAMP/htdocs/$site_name/wp-content/themes /Applications/MAMP/htdocs/$site_name/wp-content/plugins

echo "Migrating Plugins Folder..."

rsync -av --exclude=".git" ~/Documents/Projects/bunty-dev/plugins.zip /Applications/MAMP/htdocs/$site_name/wp-content/

echo "Migrating Themes Folder..."

rsync -av --exclude=".git" ~/Documents/Projects/bunty-dev/themes.zip /Applications/MAMP/htdocs/$site_name/wp-content/

cd /Applications/MAMP/htdocs/$site_name/wp-content

echo "Unpacking files and folders..."

unzip -q plugins.zip && unzip -q themes.zip

echo "Plgisn & Themes are replaced..."

echo "Resetting DB"

wp db reset

echo "Importing DB..."

wp db import ~/Documents/Projects/bunty-dev/db.sql

echo "DB Successfully imported..."

echo "Checking table prefix..."

wp option get siteurl

if [ $? -ne 0 ]; then
  echo "Please open your site's wp-config.php and change table prefix to  and run the script again."
  exit 1
fi

echo "Replacing URLs..."

wp search-replace $(wp option get siteurl) 'http://localhost:8888/'$site_name

echo "Your site URL is:" $(wp option get siteurl)

echo "Do you want to open it on your default browser?(y/n)"

read is_open

if [ $is_open == 'Y' ] ||  [ $is_open == 'y' ]
    then
        echo "Opening site....."
        open $(wp option get siteurl) #xdg-open for ubuntu
fi
