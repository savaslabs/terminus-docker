FROM composer
RUN composer global require pantheon-systems/terminus
RUN terminus auth:login --machine-token=YOUR MACHINE TOKEN HERE
