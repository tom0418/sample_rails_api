# Using mysql version 5.7.29
FROM mysql:5.7.29

# Add mysql config file to docker container
ADD ./custom.cnf /etc/mysql/conf.d/

# Run mysql container
CMD ["mysqld"]
