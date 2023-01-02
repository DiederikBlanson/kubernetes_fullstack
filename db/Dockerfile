# dump build stage
FROM postgres:14-alpine 
ENV POSTGRES_DB my_database
COPY psql_dump.sql /docker-entrypoint-initdb.d
EXPOSE 5432