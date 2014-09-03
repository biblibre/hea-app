hea-app
=======

This website intends to display koha community usage statistics. Data are collected from installed koha if librarian wants anonymously or not.

## External references

 * http://wiki.koha-community.org/w/index.php?title=KohaUsageStat_RFC
 * https://github.com/jajm/hea-ws

## Install perl libraries

* Libraries used: Dancer,  Dancer::Plugin::Database, Template
```
  # one installation way
  root # curl -L http://cpanmin.us | perl - --sudo <lib_name>
```

## Database and sample data

 1. Some mocks data are available in sql/mock-data.sql
 2. Schema is in sql/schema.sql 

## Available data for rendering

 * Metrics available in volumetry table
```
+---------------+
| name          |
+---------------+
| biblio        |
| borrowers     |
| old_issues    |
| aqorders      |
| subscription  |
| auth_header   |
| old_reserves  |
| old_reserves  |
+---------------+
```

 * System preferences recorded: a lot, see the Koha code (or patches on the bug tracker)
```
+------------+--------------+------+-----+---------+-------+
| Field      | Type         | Null | Key | Default | Extra |
+------------+--------------+------+-----+---------+-------+
| library_id | varchar(32)  | NO   |     | NULL    |       |
| name       | varchar(255) | NO   |     | NULL    |       |
| value      | text         | YES  |     | NULL    |       |
+------------+--------------+------+-----+---------+-------+
```

 * Library table
```
+--------------------------+----------------------------+--------------------+--------------+---------+
| library_id               | name                       | url                | library_type | country |
+--------------------------+----------------------------+--------------------+--------------+---------+
| 'RcP73COKh93YWLmOLkLx5Q' | hea experimental library   | http://example.com | UNIVERSITY   | France  |
+--------------------------+----------------------------+--------------------+--------------+---------+
```

