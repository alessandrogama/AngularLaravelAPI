## Installation

``` bash
# clone the repo
$ git clone https://github.com/alessandrogama/AngularLaravelAPI

## Dockerizing  application

Starting the Services __run__:
``` bash 
$ docker-compose up -d

# installing composer
$ docker-compose run --rm php composer install

# generate key
$ docker-compose run --rm php php artisan key:generate

# generate jwt secret
$ docker-compose run --rm php php artisan jwt:secret

# run database migration and seed
$ docker-compose run --rm php php artisan migrate:refresh --seed

Starting services and rebuild:
$ docker-compose up --build [noname or container_name]

Enter the workspaces:
$ docker-compose exec php bash
$ docker-compose exec angular-service /bin/sh
$ docker-compose exec db bash

See docker logs
$ docker logs --tail 50 --follow --timestamps containar_name

Reload Web Nginx
$ docker-compose exec angular-service nginx -s reload



