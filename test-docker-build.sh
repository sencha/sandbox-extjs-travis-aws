  
#!/bin/sh
# Build and run docker locally
# After Dockerfile modification, change the version!

# Build docker with version
docker build -t my-app:1.2 .

# Run docker # 8282 for testing with version
docker run -d -p 8282:3000 my-app:1.2

# List docker container ds
docker ps


# Useful docker commands:
# `docker ps` - to list container ids
# `stop docker <container_id>`
# `docker stop <container_id>`


# Bash into container and debug it
# docker exec -it <container_id> bash