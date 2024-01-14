PGPASSFILE = / home / ec2 - user /.pgpass psql \ --host=<rds-endpoint> \
--port=5432 \
--username=donohue_admin \   
--dbname=donohue
--password \

REVOKE CONNECT ON DATABASE "donohue" FROM PUBLIC donohue_admin;

GRANT CONNECT ON DATABASE "donohue" TO donohue_admin;

SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'donohue'
  AND pid <> pg_backend_pid();

DROP DATABASE "donohue";

CREATE DATABASE "donohue";