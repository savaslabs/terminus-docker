# Terminus Docker
## A Docker image for running Pantheons CLI Terminus
### Building the container
First off grab a [machine token from Pantheon](https://pantheon.io/docs/machine-tokens/) and add it to the Dockerfile on the line which runs the auth command eg:

```RUN terminus auth:login --machine-token=YOUR MACHINE TOKEN HERE```

Build the image by running ```docker build -t terminus .``` in your project root. After building the image, I recommend running the  container with the following command:

``` docker run --rm terminus [terminus command] ```

--rm will remove the container after running.

Links
* Example usage [here](https://pantheon.io/docs/terminus/examples/)
* [Terminus](https://github.com/pantheon-systems/terminus)
* More about [Docker](https://www.docker.com/)
* [Pantheon](https://pantheon.io/)


