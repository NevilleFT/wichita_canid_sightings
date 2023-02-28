# --CREATE TABLE dragons (
#   -- column_name data_type
#   --)
# 
# CREATE TABLE dragons (
#   dragon_id varchar(5) NOT NULL,
#   sex char(1) CHECK (sex IN ('M', 'F')),
#   age_class varchar(8) CHECK (age_class IN ('Adult', 'Subadult', 'Juvenile')),
#   species varchar(50),
#   PRIMARY KEY (dragon_id)
# );
# 
# --DROP TABLE dragons;
# 
# CREATE TABLE tags (
#   tag_id char(6) NOT NULL PRIMARY KEY,
#   brand varchar (50),
#   status varchar (15)
# );
# 
# CREATE TABLE sites (
#   site char(3) NOT NULL PRIMARY KEY,
#   utm_x double,
#   utm_y double
# );
# 
# SELECT * FROM dragons;
# SELECT * FROM sites;
# SELECT * FROM tags;
# 
# CREATE TABLE deployments (
#   deployment_id integer PRIMARY KEY AUTOINCREMENT,
#   dragon_id varchar(5) NOT NULL,
#   tag_id char(6) NOT NULL,
#   start_deployment text,
#   end_deployment text,
#   FOREIGN KEY (dragon_id) REFERENCES dragons(dragon_id)
#   FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
# );
# 
# CREATE TABLE deployments_temp (
#   dragon_id varchar(5) NOT NULL,
#   tag_id char(6) NOT NULL,
#   start_deployment text,
#   end_deployment text
# );
# 
# SELECT * FROM deployments_temp;
# 
# INSERT INTO deployments(dragon_id, tag_id, start_deployment, end_deployment)
# SELECT * FROM deployments_temp;
# 
# SELECT * FROM deployments;
# 
# DROP TABLE deployments_temp;
# 
# CREATE TABLE gps_raw (
#   gps_id integer PRIMARY KEY AUTOINCREMENT,
#   tag_id char(6) NOT NULL,
#   timestamp text,
#   utm_x double,
#   utm_y double,
#   FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
# );
# 
# CREATE TABLE gps_raw_temp (
#   tag_id char(6) NOT NULL,
#   timestamp text,
#   utm_x double,
#   utm_y double
# );
# 
# INSERT INTO gps_raw(tag_id, timestamp, utm_x, utm_y)
# SELECT * FROM gps_raw_temp;
# 
# SELECT * FROM gps_raw LIMIT 10;
# 
# DROP TABLE gps_raw_temp;
# 
# CREATE TABLE gps_data (
#   loc_id integer PRIMARY KEY AUTOINCREMENT,
#   dragon_id varchar(5),
#   tag_id char(6),
#   timestamp text,
#   utm_x double,
#   utm_y double,
#   FOREIGN KEY (dragon_id) REFERENCES dragons(dragon_id)
#   FOREIGN KEY (tag_id) REFERENCES tags(tag_id)
# );
# 
# INSERT INTO gps_data (dragon_id, tag_id, timestamp, utm_x, utm_y)
# SELECT 
# deployments.dragon_id,
# deployments.tag_id,
# gps_raw.timestamp,
# gps_raw.utm_x,
# gps_raw.utm_y
# FROM gps_raw LEFT JOIN deployments USING(tag_id)
# WHERE gps_raw.tag_id = deployments.tag_id AND (
#   (strftime(gps_raw.timestamp) >= strftime(deployments.start_deployment) AND strftime(gps_raw.timestamp) <= strftime(deployments.end_deployment))
#   OR 
#   (strftime(gps_raw.timestamp) >= strftime(deployments.start_deployment) AND deployments.end_deployment IS NULL)
# )
# 
# ;
# 
# SELECT * FROM gps_data LIMIT 10;