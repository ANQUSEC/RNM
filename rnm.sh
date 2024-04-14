#!/bin/bash

# Change directory
cd /www/server/panel/vhost/nginx

# Replace 'air-jx.lat' with 'air-jx.vip' in all .conf files
sed -i 's/air-jx.lat/air-jx.vip/g' *.conf

# Remove any crontab entries containing 'air-jx'
sudo crontab -l | grep -v "air-jx" | sudo crontab -

# Add a new cron job
(crontab -l ; echo "0 6 * * * cd /www/server/panel/vhost/nginx && (grep -q -r 'air-jx.lat' *.conf || (grep -rl '#Ec#ERROR-PAGE-END/a \ server_name _;\\n   return 301   https://air-jx.vip ;' *.conf && sudo /etc/init.d/nginx restart))") | crontab -

# Display bash history
cat ~/.bash_history

# Restart Nginx
sudo /etc/init.d/nginx restart

# Clear history
history -c && echo > ~/.bash_history
