# Terminus Docker

## Usage

### Docker Compose example

``` yaml
terminus:
  image: savaslabs/terminus-docker
  environment:
    TERMINUS_CACHE_DIR: "/terminus/cache"
  volumes:
    - terminus-data:/terminus/cache
    - ./:/app:cached
  volumes_from:
    - php
volumes:
  terminus-data:
    driver: local
```

This is in the broader context of the standard `docker-compose.yml` provided by the [Docker4Drupal](https://github.com/wodby/docker4drupal) project.

In your build script for setting up your site, you would do something like:

``` sh
docker volume create --name=examplesite_terminus-data
docker-compose run --rm --entrypoint="sh -c" terminus "mkdir -p /terminus/cache/tokens"
ifdef TRAVIS
	docker-compose run --rm terminus auth:login --machine-token=$$TERMINUS_TOKEN
else
	read -p "Please enter Terminus token [Enter] " TERMINUS_TOKEN && docker-compose run --rm terminus auth:login --machine-token=$$TERMINUS_TOKEN
endif
	docker-compose run --rm terminus site:info examplesite
```

Note that if the environment variable `$TRAVIS` is set, the above runs non-interactively.

Once you have authenticated, you can run commands like so:

```
docker-compose run --rm terminus backup:create examplesite.live -n --element=db --keep-for=1
docker-compose run --rm terminus backup:get examplesite.live -n --element=db --to=cache/database.sql.gz
```

### docker run example

``` sh
#!/bin/sh
set -ex
docker pull savaslabs/terminus-docker:latest
docker volume create examplesite-terminus
docker run --rm -e TERMINUS_CACHE_DIR=/terminus/cache -v examplesite-terminus:/terminus/cache savaslabs/terminus-docker auth:login --machine-token=$MACHINE_TOKEN
docker run --rm -e TERMINUS_CACHE_DIR=/terminus/cache -v /var/lib/jenkins/.ssh:/root/.ssh:ro -v examplesite-terminus:/terminus/cache savaslabs/terminus-docker drush examplesite.live -- cron -v
```
