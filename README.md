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
