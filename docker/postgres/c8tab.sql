
psql -h localhost -p 5432 -d docker -U docker --docker

CREATE TABLE cities (name  varchar(80), location        point);
INSERT INTO cities VALUES ('San Francisco', '(-194.0, 53.0)');
select * from cities;
   