echo 'update service config'

sed -i -- 's/apiKey.*/apiKey = "'"$NUGET_API_KEY"'";/g' $NUGET_PATH/inc/config.php 
sed -i -- 's/example.com/'"$NUGET_HOST"'/g' /etc/nginx/conf.d/default.conf 
sed -i -- 's/return.*http:.*;/return "'"$NUGET_DEFAULT_HTTP"':\/\/";/g' $NUGET_PATH/inc/core.php 

chown nginx_docker /app/db
chown nginx_docker /app/packagefiles

echo 'Starting services'
/etc/init.d/php7.0-fpm start
/etc/init.d/php7.0-fpm restart
/etc/init.d/nginx restart

tail -f /dev/null