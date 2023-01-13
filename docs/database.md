# Database

The database used here is a straightforward Postgres database that comprises of a single table. The `system/db` directory contains both a Dockerfile and a Postgres dump file. The dump file is used to insert data into the container when the image is built using the Dockerfile.

--- 
sources:
- https://www.containiq.com/post/deploy-postgres-on-kubernetes