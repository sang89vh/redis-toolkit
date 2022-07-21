#set connection data accordingly
source_host=127.0.0.1
source_port=6379
source_db=10
source_auth=admin1

target_host=127.0.0.1
target_port=6379
target_db=12
target_auth=admin2

#copy all keys without preserving ttl!
redis-cli -a $source_auth -h $source_host -p $source_port -n $source_db keys \* | while read key; do
    echo "redis-cli -h $source_host -p $source_port -a $source_auth -n $source_db MIGRATE $target_host $target_port "" $target_db 5000 COPY AUTH $target_auth KEYS $key"
    #redis-cli --raw -h $source_host -p $source_port -n $source_db DUMP "$key" \
    #    | head -c -1 \
    #    | redis-cli -x -h $target_host -p $target_port -n $target_db RESTORE "$key" 0
    redis-cli -h $source_host -p $source_port -a $source_auth -n $source_db MIGRATE $target_host $target_port "" $target_db 5000 COPY AUTH $target_auth KEYS $key
done
