hea-app
=======


## Install perl libraries

root # curl -L http://cpanmin.us | perl - --sudo Dancer
root # perl cpanminus.pl --sudo Dancer::Plugin::Database                                                              

## Create database and mock data

root # cat create-database.sh 
#!/bin/bash

DB=hea
USER=hea
PASS=test

mysql -e "CREATE DATABASE $DB CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL privileges ON $DB.* TO $USER@'localhost' IDENTIFIED BY '$PASS';"

mysql -u hea -ptest hea < sql/mock-data.sql
