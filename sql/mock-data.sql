/* insert 4 samble libraries. The 4th is anonymous */
insert into library(library_id,name,url,library_type,country) values ('ZJQn4+w4m02oeLpmYgEoVQ','hea experimental library (éàçλλλ)','http://example.com','UNIVERSITY','France');
insert into library(library_id,name,url,library_type,country) values ('trlZWtX4uZxSQYowVpOZXg','hea experimental library 2','http://example.com','PUBLIC','England');
insert into library(library_id,name,url,library_type,country) values ('sbSA/HVoGKhdw7C5ESaIWw','hea experimental library 3','http://example.com','UNIVERSITY','France');
insert into library(library_id,name,url,library_type,country) values ('3kJSqWLI1pzV/aBWdcQw7g','','','PUBLIC','Germany');

/* insert the size of the biblio table for those 4 sample */
insert into volumetry (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','biblio',13243);
insert into volumetry (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','biblio',200653);
insert into volumetry (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','biblio',32123);
insert into volumetry (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','biblio',444233);

insert into volumetry (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','auth_header',23478);
insert into volumetry (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','auth_header',432904);
insert into volumetry (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','auth_header',74322);
insert into volumetry (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','auth_header',843243);

insert into volumetry (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','borrowers',32122);
insert into volumetry (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','borrowers',59834);
insert into volumetry (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','borrowers',74322);
insert into volumetry (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','borrowers',2393);

insert into volumetry (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','items',32123);
insert into volumetry (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','items',743134);
insert into volumetry (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','items',54323);
insert into volumetry (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','items',754234);

insert into volumetry (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','old_issues',132093);
insert into volumetry (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','old_issues',783234);
insert into volumetry (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','old_issues',234312);
insert into volumetry (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','old_issues',9384321);

insert into volumetry (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','old_reserves',5093);
insert into volumetry (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','old_reserves',7234);
insert into volumetry (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','old_reserves',2412);
insert into volumetry (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','old_reserves',95321);

insert into volumetry (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','aqorders',2093);
insert into volumetry (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','aqorders',8234);
insert into volumetry (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','aqorders',3412);
insert into volumetry (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','aqorders',4321);

insert into volumetry (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','subscription',1209);
insert into volumetry (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','subscription',7823);
insert into volumetry (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','subscription',2341);
insert into volumetry (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','subscription',9843);

/* insert various systempreferences for those 4 samples */
insert into systempreference (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','marcflavour','marc21');
insert into systempreference (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','marcflavour','normarc');
insert into systempreference (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','marcflavour','unimarc');
insert into systempreference (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','marcflavour','unimarc');

insert into systempreference (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','opacthemes','prog');
insert into systempreference (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','opacthemes','bootstrap');
insert into systempreference (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','opacthemes','bootstrap');
insert into systempreference (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','opacthemes','bootstrap');

insert into systempreference (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','OAI-PMH','0');
insert into systempreference (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','OAI-PMH','1');
insert into systempreference (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','OAI-PMH','0');
insert into systempreference (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','OAI-PMH','1');

insert into systempreference (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','ILS-DI','0');
insert into systempreference (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','ILS-DI','1');
insert into systempreference (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','ILS-DI','1');
insert into systempreference (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','ILS-DI','1');

insert into systempreference (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','QuoteOfTheDay','0');
insert into systempreference (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','QuoteOfTheDay','0');
insert into systempreference (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','QuoteOfTheDay','1');
insert into systempreference (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','QuoteOfTheDay','1');

insert into systempreference (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','TagsEnabled','0');
insert into systempreference (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','TagsEnabled','0');
insert into systempreference (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','TagsEnabled','0');
insert into systempreference (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','TagsEnabled','1');

insert into systempreference (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','OPACdefaultSortField','relevance');
insert into systempreference (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','OPACdefaultSortField','relevance');
insert into systempreference (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','OPACdefaultSortField','title');
insert into systempreference (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','OPACdefaultSortField','author');

insert into systempreference (library_id,name,value) values ('ZJQn4+w4m02oeLpmYgEoVQ','version','3.12');
insert into systempreference (library_id,name,value) values ('trlZWtX4uZxSQYowVpOZXg','version','3.16');
insert into systempreference (library_id,name,value) values ('sbSA/HVoGKhdw7C5ESaIWw','version','4.08');
insert into systempreference (library_id,name,value) values ('3kJSqWLI1pzV/aBWdcQw7g','version','3.16');
