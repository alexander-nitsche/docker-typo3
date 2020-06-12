## Debugging Nginx
In order to enable logging at debug level you will have to add the following line to the end of the
Nginx [Dockerfile](nginx/Dockerfile)
```bash
CMD ["nginx-debug", "-g", "daemon off;"]
```
and adapt the Nginx [configuration](nginx/nginx.conf)
```bash
error_log /var/log/nginx/error.log debug;
```

## Debugging PHP
In the local development environment Xdebug is available at port 9001 and tries
to connect to the host machine via 10.254.254.254. Thus make sure that this IP
points to your loopback, e.g. like this:

* for Mac

```bash
# see: https://gist.github.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93
$ sudo curl -o /Library/LaunchDaemons/com.ralphschindler.docker_10254_alias.plist https://gist.githubusercontent.com/ralphschindler/535dc5916ccbd06f53c1b0ee5a868c93/raw/com.ralphschindler.docker_10254_alias.plist
```

* for Linux

```bash
$ sudo vi /etc/network/interfaces
# interfaces(5) file used by ifup(8) and ifdown(8)
auto lo lo:10
iface lo inet loopback
iface lo:10 inet static
    address 10.254.254.254
    netmask 255.255.255.255
```

Save and restart the machine.

## TODOS

- how to own /var/www/html with the correct user "www-data" and run the container with www-data
    - [x] same user id and group id in nginx and php container
    - [x] change owner and group of document root accordingly
    - [ ] add documentation / warning if document root is mount from host: the folder has to be created manually
            on the host with the according user and group as docker has no rights to do it by default
- run all containers with non-privileged users and make all required folders and files accessable
    - [ ] php container
    - [ ] nginx container
    - [ ] mariadb container
- replace /usr/local/etc/php by $PHP_INI_DIR
- TYPO3: how to expose nginx port 8080 without
  ```
  The current host header value does not match the configured trusted hosts pattern!
  ```
    - (SERVER_NAME:SERVER_PORT !== HTTP_HOST)
    - probably due to missing fastcgi params in nginx configuration
- TYPO3: Resolve
    ```
    $GLOBALS[TYPO3_CONF_VARS][SYS][systemLocale] is not set. This is fine as long as no UTF-8 file system is used.
    ```
- TYPO3: Resolve some failing Image Processing tests
