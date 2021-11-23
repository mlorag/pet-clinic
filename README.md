# PetClinic Application

This application is used to illustrate DevOps practices.

This repository is a fork of the [spring-petclinic/spring-framework-petclinic](https://github.com/spring-petclinic/spring-framework-petclinic).
Customization has been added for training purpose.

Feel free to fork this repo.

<img width="1042" alt="petclinic-screenshot" src="https://cloud.githubusercontent.com/assets/838318/19727082/2aee6d6c-9b8e-11e6-81fe-e889a5ddfded.png">

# Levantar utilizando MySQL

Por defecto la aplicación levanta utilizando una BD embebida, para levantar la aplicación con MySQL seguir lo siguientes pasos:

**Levantar MySQL**

Crear la red interna.
`docker network create --driver bridge petclinic-network`

Levantar el contenedor de MySQL.
`docker run --name mysql -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=petclinic -d -p 3306:3306 --network=petclinic-network mysql`

Ingresar al contenedor de MySQL y ejecutar un backup de la BD.

```
docker exec -it mysql /bin/bash
mysql -u root -p < dump.sql
mysql -u root -p petclinic
mysql> select * from vets;
```

**Levantar la Aplicación**

Genera la imagen.
`docker build -t snahider/devopslab-pet-clinic:production-latest -f Dockerfile.build_and_deploy .`

Levantar el contenedor.
`docker run --name petclinic -p 8080:8080 --network=petclinic-network snahider/devopslab-pet-clinic:production-latest --spring.profiles.active=mysql --spring.datasource.password=123456`
