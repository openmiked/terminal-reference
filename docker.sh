docker --version
docker info
docker stats
docker ps

docker build -t <image-name> .

docker container exec [OPTIONS] <container-name> [COMMAND]
docker container ls --all
docker container ls -aq
docker container inspect			------> shows JSON of container config
docker container inspect --format '{{ .NeworkSettings.IPAddress }}'
docker container logs <container-name>
docker container logs -f/--follow <container-name>
docker container rm [--force] <container-name>
docker container run [OPTIONS] <container-name> [COMMAND]
docker container run -it <container-name> bash
docker container run -d -p <external-port>:<internal-port> <container-name> <image-name> [--rm = delete when closed]
docker container start [OPTIONS] <container-name>
docker container start -ai <container-name>
docker container stats				------> shows realtime stats of container resources
docker container stop [OPTIONS] <container-name>
docker container top				------> show all running processes in a container

docker exec -u <user-name> -it <container-name> sh

docker image ls
docker images -a

docker network ls	
docker network inspect
docker network create --driver
docker network connect
docker network disconnect

docker system df
docker system prune [OPTIONS]
docker system prune -a

docker-machine ls
docker-machine create <docker-machine-name>
docker-machine env <docker-machine-name>
docker-machine rm <docker-machine-name>
docker-machine start <docker-machine-name>
docker-machine stop <docker-machine-name>

eval $(<cluster-name> docker-env)   ------> ex:  eval $(minikube docker-env)

docker run -d -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=tmpAdmnPass123" -p 1433:1433 -v customer-db-volume:/var/opt/mssql --name customer-db mcr.microsoft.com/mssql/server:2019-latest
docker run --name eventstore-node -d -p 2113:2113 -p 1113:1113 eventstore/eventstore
docker run --name eventstore-node -d -p 80:80 -p 1113:1113 -e EVENTSTORE_EXT_HTTP_PORT=80 -e EVENTSTORE_EXT_HTTP_PREFIXES='http://*/' eventstore/eventstore

# Networks
* None
* Host
* Bridge