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
ADD pgpool2/pcp.conf /etc/pgpool2/pcp.conf
ADD pgpool2/pgpool.conf /etc/pgpool2/pgpool.conf
ADD pgpool2/pool_hba.conf /etc/pgpool2/pool_hba.conf

CMD [pgpool]