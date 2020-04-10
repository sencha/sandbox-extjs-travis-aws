  
#!/bin/sh
# build and run docker locally

# build docker
docker build -t my-app:1.2 .

# run docker # 8282 for testing
docker run -d -p 8282:3000 my-app:1.2

# list dockers
docker ps


# `docker ps` - to list containers
# `stop docker [container_id]`
# `docker stop [container_id]`


# debugging in container
# docker exec -it [container_id] bash