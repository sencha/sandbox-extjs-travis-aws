  
#!/bin/sh
# Build and run docker locally
# After Dockerfile modification, change the version!

# Build docker
docker build -t my-app:1.2 .

# Run docker # 8282 for testing
docker run -d -p 8282:3000 my-app:1.2

# List dockers
docker ps


# `docker ps` - to list containers
# `stop docker [container_id]`
# `docker stop [container_id]`


# debugging in container
# docker exec -it [container_id] bash