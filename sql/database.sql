mkdir -p /db/library/data
mkdir -p /db/library/index
chown -R postgres.postgres /db/library 
useradd lbadm -Gpostgres -gpostgres 
passwd lbadm --stdin
useradd lbuser -Gpostgres -gpostgres 
passwd lbuser --stdin
service postgresql restart
su - postgres
psql template1
CREATE GROUP library;
CREATE USER lbadm WITH ENCRYPTED PASSWORD '1q2w3e4r5t' CREATEDB CREATEUSER;
CREATE USER lbuser WITH ENCRYPTED PASSWORD '123456';
CREATE TABLESPACE librarydata OWNER lbadm LOCATION '/db/library/data';
CREATE TABLESPACE libraryindex OWNER lbadm LOCATION '/db/library/index';
CREATE DATABASE library WITH ENCODING='unicode' OWNER=lbadm TEMPLATE=template1 TABLESPACE=librarydata;
\c library
CREATE SCHEMA library AUTHORIZATION lbadm;
GRANT ALL ON SCHEMA library TO lbadm;
COMMENT ON DATABASE library IS 'Base de datos para la biblioteca virtual';
COMMENT ON SCHEMA library IS 'Eschema para los objetos de la bibliteca virtual';

ALTER USER lbadm SET SEARCH_PATH TO library;
ALTER USER lbuser SET SEARCH_PATH TO library;

CREATE LANGUAGE plpgsql;
