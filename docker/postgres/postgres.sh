##Build an image from the Dockerfile assign it a name.
docker build -t eg_postgresql .

##Run the PostgreSQL server container (in the foreground):
docker run -p 5432:5432 -d --name pg_test eg_postgresql

docker run -p 5432:5432 -v /c/Users/dockerdata/postgres/data:/var/lib/postgresql/data --name pg_test -d eg_postgresql
docker run -p 5432:5432 --name pg_test -d eg_postgresql

docker run --rm --volumes-from pg_test -v /c/Users/dockerdata/postgres:/backup -t -i busybox sh

-v /c/Users/dockerdata/postgres/data:/var/lib/postgresql/data

Create Data Volume Containers:
---------------------------------
docker run -d -P --name test-container -v /webapp training/webapp python app.py

docker run -d -P --name test-container -v /c/Users/dockerdata/postgres/data:/var/lib/postgresql/data


This creates a container named postgresdata based off of the ubuntu image and in the directory /c/Users/dockerdata/postgres
-------------------------------------------------------------------------------------------------------
docker create -v /c/Users/dockerdata/postgres:/var/lib/postgresql --name datacontainer ubuntu

docker run -p 5432:5432 --volumes-from datacontainer --name pg_test -d eg_postgresql


Backup, restore, or migrate data volumes
-------------------------------------------
Another useful function we can perform with volumes is use them for backups, restores or migrations. 
You do this by using the --volumes-from flag to create a new container that mounts that volume, like so:

$ docker run --rm --volumes-from pg_test -v /c/Users/dockerdata/postgres:/backup ubuntu tar cvf /backup/backup.tar /var/lib/postgresql

Here you’ve launched a new container and mounted the volume from the dbstore container. 
You’ve then mounted a local host directory as /backup. Finally, you’ve passed a command that uses tar to backup 
the contents of the dbdata volume to a backup.tar file inside our /backup directory. When the command completes 
and the container stops we’ll be left with a backup of our dbdata volume.

You could then restore it to the same container, or another that you’ve made elsewhere. Create a new container.

$ docker run -v /dbdata --name dbstore2 ubuntu /bin/bash
Then un-tar the backup file in the new container`s data volume.

$ docker run --rm --volumes-from dbstore2 -v $(pwd):/backup ubuntu bash -c "cd /dbdata && tar xvf /backup/backup.tar --strip 1"
You can use the techniques above to automate backup, migration and restore testing using your preferred tools.
