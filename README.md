A Basic Example of Docker Using LAMP
------------------------------------
This project demonstrates a basic workspace for creating a Docker image using LAMP as an example platform

Building
------------------------------------
Clone the project and then from the working directory use

```
sudo docker build -t lamp .
```

Running
------------------------------------
Once built use the following to run the container

```
docker run -d -p [HOST WWW PORT NUMBER]:80 -p [HOST DB PORT NUMBER]:3306 -v [HOST WWW DOCUMENT ROOT]:/var/www/html -v [HOST DB DOCUMENT ROOT]:/var/lib/mysql
```

visit localhost in a browser. It should show a phpinfo page
