#! /bin/bash

cd /Applications/MAMP/htdocs/

echo "Enter WordPress site name you want to DELETE ( Just a folder name added in htdocs ):"

read site_name

cd $site_name

echo "Are you sure you want to DELETE?:( y/n )" $(wp option get siteurl)

read want_delete

if [ $want_delete == 'Y' ] ||  [ $want_delete == 'y' ]
    then
        echo "Deleting site....."
        echo "Deleting DB....."
        wp db drop --yes
        echo "Database Deleted"
        cd ..
        echo "Deleting Files..."
        rm -rf $site_name
        echo "Files deleted."
        echo "DELETED the Site."
fi
