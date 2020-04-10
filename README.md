# Deploying your Ext JS Application to Elastic Beanstalk
This example covers deploying your Ext JS application to Elastic Beanstalk.

This configuration includes:
- npm & node.js
- webpack 
- travis CI 
- AWS Elastic Beanstalk
- Ext JS

## Set up VCS
Configure a VCS to store your code. 

```
cd ~/git/sandbox-extjs-travis-aws
```

## Create a project
Create an Ext JS npm project.

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


## Configure AWS & EB CLI
Install and configure the AWS and EB CLI.

* [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
* [Install EB CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html)
* [Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

At the root of the project run this. In this config, don't run it in the app folder. 
```
aws configure
```



## Create Elastic Beanstalk Application
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


## Create Elastic Beanstalk Environment.
Set up an Elastic environment for your application. 

```
eb create sandbox-staging
```


## Configure the Docker
Create a [./Dockerfile](./Dockerfile).

* Copy the [./Dockerfile](./Dockerfile) to your application. It sets up a basic linux enviroment. 

Note: I won't be covering how to build and save the image on AWS. 



## Configure Docker Run Manifest
Create a [./Dockerrun.aws.json](./Dockerrun.aws.json) docker maniftest. 

* Copy the [./Dockerfile](./Dockerfile) to your application.

Note: I won't be covering how to build using a saved image in this round. I'll use a basic ubuntu config. 



## Configure package.json
Add express and change how the server is started. 

* Copy the [./package.json](./package.json) to your project. 
* This project contains express. 
* This project contains a start script to start web express serving. 



## Configure TravisCI

* Copy the [.travis.yml](./travis.yml) to your project. 
* TODO - encrypt aws token/pass.


## Debug Proxy Config
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
Debug in VSCode. 

1. Start the `Server` launcher. http://localhost:3000/api
2. Start the `Client` launcher. http://localhost:1962/

- The Client launcher launches web pack dev server which watches for changes. On a change it builds. 
- The Client launcher has a proxy from http://localhost:1962/api to http://localhost:3000/api.


## Deploy
.travis.yml is set up to deploy to Elastic Beanstalk.

* Change the username and password in [./travis.yml](./.travis.yml).

