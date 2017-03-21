FROM composer

RUN composer global require pantheon-systems/terminus

ENTRYPOINT ["terminus"]
