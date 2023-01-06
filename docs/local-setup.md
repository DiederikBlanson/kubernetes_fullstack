# Local Setup
To run the fullstack application locally, the only prerequisite is to have Docker installed. The frontend, backend, and database are all contained in Docker containers, which are linked to each other using `docker-compose`.

The local setup uses the docker-compose-dev.yml script. The containers function as follows:
1. React: A node container is spun up and the command yarn start is executed. To make real-time changes visible in the container, the source code is mounted through a volume. The app will automatically refresh thanks to the `FAST_REFRESH` and `WATCHPACK_POLLING` environment variables.
2. NodeJS: TODO
3. DB: TODO

## Run the container
1. In the root folder, execute the following command to build the environment:
```bash
docker-compose -f docker-compose-dev.yml build
```
2. Then, run the container using this command:
```bash
docker-compose -f docker-compose-dev.yml up
```