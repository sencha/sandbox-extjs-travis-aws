# Deploying your Ext JS Application to Elastic Beanstalk
This example covers deploying your Ext JS application to Elastic Beanstalk.

[![Build Status](https://travis-ci.com/sencha/sandbox-extjs-travis-aws.svg?token=KdcJCzakCyZqGAcQgvVY&branch=master)](https://travis-ci.com/sencha/sandbox-extjs-travis-aws)

This configuration includes:
- npm & node.js
- webpack 
- travis CI 
- AWS Elastic Beanstalk
- Ext JS

This architecture configuration includes:
- ./client - Ext JS app source - http://localhost:1962 (Endpoint for debugging only)
- ./server - Server app source - http://localhost:3000

This Elastic Beanstalk configuration includes:
- Multi-Docker container config - http://localhost:3000

This Client application includes:
- Visual Studio Code launchers for client, server & Chrome
- Client launcher - webpack dev server - http://localhost:1962 - with a proxy to server
- Server launcher - express server - http://localhost:3000
- Client debugging proxy - http://localhost:1962/api to http://localhost:3000/api

## VCS Configuration
Configure a VCS to store your code. 

Once the project is configured it will be your project root. 
Change to the root of your project.
```
cd ~/git/sandbox-extjs-travis-aws
```


## Create an Ext JS Application
Create an Ext JS npm Ext JS application project.

### Sign in to npm Repo

```
npm login --registry=https://npm.sencha.com --scope=@sencha
```

### Install the Application Generator

```
npm install -g @sencha/ext-gen
```

### Generate an Application

```
ext-gen app -a -t moderndesktop -n ModernApp
```

###  Open the Application
Test out the project. 

```
cd ./modern-app
```

```
npm start
```

### Prep Client/Server Config

Rename `./modern-app` to `client`.
```
mv modern-app client
```

## Configure Elastic Beanstak App & Enviornment

### Configure AWS & EB CLI
Install and configure the AWS and EB CLI.

* [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
* [Install EB CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html)
* [Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

At the root of the project run this. In this config, don't run it in the app folder. 
```
aws configure
```

### Create Elastic Beanstalk Application
Set up the Elastic Beanstalk application.

```
eb init
```

* Choose the datacenter that makes sense to you
* Choose `Create New Application`
* Choose `Multi-container Docker` and the latest version.
* Do not choose CodeCommit.
* Choose setup SSH, if you want to use SSH.

This will create the file [./.elasticbeanstalk/config.yml](./.elasticbeanstalk/config.yml).

### Create Elastic Beanstalk Environment.
Set up an Elastic environment for your application. 

```
eb create sandbox-staging
```

## Docker Config
The `Dockerrun.aws.json` will configure the docker container when deployed. 


## Configure Client / Server Application

### Configure package.json
Add express and change how the server is started. 

* Copy the [./package.json](./package.json) to your project. 
* This project contains express. 
* This project contains a start script to start web express serving. 

### Configure TravisCI

* Copy the [.travis.yml](./travis.yml) to your project. 
* TODO - encrypt aws token/pass.

### Debug Proxy Config
In order to use the web pack dev server and server together, you'll need to set up a proxy in the web pack dev server. 
This allows you to run the web pack dev server with all the magic with a separate server instance.

Add this proxy to your webpack `devServer` configuration. 
```
// http://localhost:1962/api
proxy: {
  "/api": "http://localhost:3000"
}
```

For `devServer` example:
```
devServer: {
  watchOptions: {
    ignored: ignoreFolders
  },
  contentBase: [path.resolve(__dirname, outputFolder)],
  watchContentBase: !isProd,
  liveReload: !isProd,
  historyApiFallback: !isProd,
  host: host,
  port: port,
  disableHostCheck: isProd,
  compress: isProd,
  inline: !isProd,
  stats: stats,

  // http://localhost:1962/api
  proxy: {
    "/api": "http://localhost:3000"
  }
}
```


## Debugging
Debug using launchers in Visual Studio Code. Start the Server, Client and Chrome launcher to debug locally. 

1. Start the `Server` launcher. http://localhost:3000/api
2. Start the `Client` launcher. http://localhost:1962/
3. Start the `Chrome` launcher. This opens chrome and connects it to Visual Studio Code.

- The Client launcher launches web pack dev server which watches for changes. On a change it builds. 
- The Client launcher has a proxy from http://localhost:1962/api to http://localhost:3000/api.

See the launchers here [./vscode/launch.json](./vscode/launch.json).


## Deploy
.travis.yml is set up to deploy to Elastic Beanstalk.

* Change the username and password in [./travis.yml](./.travis.yml).


## AWS Endpoint
The application deploys to http://sandbox-staging.eba-te2gi7ki.us-east-1.elasticbeanstalk.com/.
