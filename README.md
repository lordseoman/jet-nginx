# jet-nginx
Docker container for an NginX Proxy to with the Jet Billing System

./bin/build <realm> <version>

./bin/run 

./bin/enter <user>

TODO:

 1. Not starting as /opt/nginx/log/ isn't accessible although it is
    checked in the entrypoint.sh script.

 2. ssl and other realm/site config should go in /mnt/Nginx/conf.d/
    and /mnt/Nginx/ssl/

 3. static pages need to go in /mnt/Nginx/html/

 4. SCRIPTARGS still not coming through properly

