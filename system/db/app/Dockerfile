# dump build stage
FROM postgres:14-alpine 
COPY psql_dump.sql /docker-entrypoint-initdb.d
EXPOSE 5432