#!/bin/bash

{
	echo ""
	echo "# - Backend Connection Settings -"
	echo ""

	IFS=', ' read -r -a array <<< $BACKEND_IP

	for index in "${!array[@]}"
	do
	    echo "backend_hostname$index = ${array[index]}"
		echo "backend_port$index = 5432"
		echo "backend_weight$index = 1"
		echo "backend_data_directory$index = '/data$index'"
		echo "backend_flag$index = 'ALLOW_TO_FAILOVER'"
		echo ""
	done

} >> /usr/local/etc/pgpool.conf


#RUN pgpool
pgpool -n
