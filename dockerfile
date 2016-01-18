FROM postgres:9.4 

RUN apt-get update

#install pgpool
RUN apt-get install pgpool2

# pgpool
EXPOSE 9999

# Add conf files
ADD /etc/pgpool2/pcp.conf
ADD /etc/pgpool2/pgpool.conf
ADD /etc/pgpool2/pool_hba.conf

CMD [pgpool]