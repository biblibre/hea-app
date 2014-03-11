hea-app
=======

This website intends to display koha community usage statistics. Data are collected from installed koha if librarian wants anonymously or not.

## Install perl libraries

  root # curl -L http://cpanmin.us | perl - --sudo Dancer
  root # perl cpanminus.pl --sudo Dancer::Plugin::Database                                                              
  root # perl cpanminus.pl --sudo Template                                                              

## Create database and mock data

  root # cat create-database.sh 

  #!/bin/bash
  
  DB=hea
  USER=hea
  PASS=test
  
  mysql -e "CREATE DATABASE $DB CHARACTER SET utf8 COLLATE utf8_bin;"
  mysql -e "GRANT ALL privileges ON $DB.* TO $USER@'localhost' IDENTIFIED BY '$PASS';"

- Some mocks data are available in sql/mock-data.sql
- Schema is in sql/schema.sql 
