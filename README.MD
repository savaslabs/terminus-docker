# Terminus Docker
## A Docker image for running Pantheons CLI Terminus

### SSH Key
Pantheon uses ssh so first off run the following commands localy to add you SSH Key to SSH-AGENT: [ref:](http://dchua.com/2016/01/15/ssh-agent-forwarding-with-your-docker-container/)
```
$ eval $(ssh-agent)
$ ssh-add
```
You should see ```Identity added: ...```

### Building the container
First off grab a [machine token from Pantheon](https://pantheon.io/docs/machine-tokens/) and add it to the Dockerfile on the line which runs the auth command eg:

``` RUN terminus auth:login --machine-token=YOUR MACHINE TOKEN HERE ```

Build the image by running

 ```$ docker build -t terminus-image-name .``` in your project root. 

After building the image, I recommend running the  container with the following command:

``` $ docker run -it -d -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent terminus-image bash```

This will enable your container to use your ssh key. Running ``` $ docker ps ``` will show us our knew container running:

```1db0277c83a7        terminus-image      "/docker-entrypoin..."   13 minutes ago      Up 13 minutes keen_babbage'''


To run a terminus command:

```$ docker exec -it [container-name] terminus [command]```

EG:

``` $ docker exec -it [container_name] terminus remote:drush site-name.dev fl```

I would also recommend adding the following alias to your .bashrc
> alias dockerterm="docker exec -it [container_name] terminus"


Links

* Example usage [here](https://pantheon.io/docs/terminus/examples/)
* [Terminus](https://github.com/pantheon-systems/terminus)
* More about [Docker](https://www.docker.com/)
* [Pantheon](https://pantheon.io/)


