/* insert 4 samble libraries. The 4th is anonymous */
insert into library(name,url,library_type,country) values ('hea experimental library','http://example.com','UNIVERSITY','France');
insert into library(name,url,library_type,country) values ('hea experimental library 2','http://example.com','PUBLIC','England');
insert into library(name,url,library_type,country) values ('hea experimental library 3','http://example.com','UNIVERSITY','France');
insert into library(name,url,library_type,country) values ('','','PUBLIC','Germany');

/* insert the size of the biblio table for those 4 sample */
insert into volumetry (library_id,name,value,inserted) values (1,'biblio',13243,1394529501);
insert into volumetry (library_id,name,value,inserted) values (2,'biblio',200653,1394529501);
insert into volumetry (library_id,name,value,inserted) values (3,'biblio',13243,1394529501);
insert into volumetry (library_id,name,value,inserted) values (4,'biblio',200653,1394529501);

/* insert various systempreferences for those 4 samples */
insert into systempreference (library_id,name,value) values (1,'marcflavour','marc21');
insert into systempreference (library_id,name,value) values (2,'marcflavour','normarc');
insert into systempreference (library_id,name,value) values (3,'marcflavour','unimarc');
insert into systempreference (library_id,name,value) values (4,'marcflavour','unimarc');

insert into systempreference (library_id,name,value) values (1,'IndependentBranches','0');
insert into systempreference (library_id,name,value) values (2,'IndependentBranches','0');
insert into systempreference (library_id,name,value) values (3,'IndependentBranches','1');
insert into systempreference (library_id,name,value) values (4,'IndependentBranches','1');

