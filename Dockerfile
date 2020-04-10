FROM ubuntu:18.04

# Install basics
RUN apt-get update
RUN apt-get install -y awscli
RUN apt-get install -y build-essential curl

# node
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get install -y nodejs

WORKDIR /app/current

COPY . /app/current
COPY ./client/build/production/ModernApp/ /app/current/server/html/

CMD ["node", "./server/express.js"]

EXPOSE 3000
