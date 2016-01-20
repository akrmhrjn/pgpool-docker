#!/bin/bash

{
	echo ""
	echo "# - Backend Connection Settings -"
	echo ""

	echo "#backend_hostname0 = 0.0.0.0
                                   # Host name or IP address to connect to for backend 0
#backend_port0 = 5432
                                   # Port number for backend 0
#backend_weight0 = 1
                                   # Weight for backend 0 (only in load balancing mode)
#backend_data_directory0 = '/data'
                                   # Data directory for backend 0
#backend_flag0 = 'ALLOW_TO_FAILOVER'
                                   # Controls various backend behavior
                                   # ALLOW_TO_FAILOVER or DISALLOW_TO_FAILOVER
                                   "

	IFS=', ' read -r -a array <<< $BACKEND_HOSTNAME

	for index in "${!array[@]}"
	do
		echo ""
	    echo "backend_hostname$index = '${array[index]}'"
		echo "backend_port$index = 5432"
		echo "backend_weight$index = 1"
		echo "backend_data_directory$index = '/data$index'"
		echo "backend_flag$index = 'ALLOW_TO_FAILOVER'"
	done

} >> /usr/local/etc/pgpool.conf


#RUN pgpool
pgpool -n
