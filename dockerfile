FROM postgres:9.4 

RUN apt-get update
RUN apt-get install -y postgresql-server-dev-9.4 apache2 libapache2-mod-php5 curl build-essential

# Download pgpool
RUN curl -L -o pgpool-II-3.4.0.tar.gz http://www.pgpool.net/download.php?f=pgpool-II-3.4.0.tar.gz 
RUN tar zxvf pgpool-II-3.4.0.tar.gz

# Build pgpool2
WORKDIR /pgpool-II-3.4.0
RUN ./configure
RUN make
RUN make install

# Build pgpool2 extensions for postgres
WORKDIR /pgpool-II-3.4.0/src/sql
RUN make
RUN make install

RUN ldconfig

# clean up
RUN rm -rf /pgpool-II-3.4.0 & rm /pgpool-II-3.4.0.tar.gz

# pgpool
EXPOSE 9999

# Add conf files
ADD pgpool2/pcp.conf /usr/local/etc/pcp.conf
ADD pgpool2/pgpool.conf /usr/local/etc/pgpool.conf
ADD pgpool2/pool_hba.conf /usr/local/etc/pool_hba.conf

#set up configuration files and run pgpool
ADD start.sh /tmp/start.sh
RUN chmod 777 /tmp/start.sh

ENTRYPOINT ["/tmp/start.sh"]