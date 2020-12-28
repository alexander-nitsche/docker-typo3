## Installation
```
# Copy and adapt
cp .env-template .env

# Build Docker images
make build

# Start Docker services
make start

# Install TYPO3 in Composer mode
make install
```

## Debugging Nginx
In order to enable logging at debug level you will have to uncomment the following
lines at the Docker Compose file, e.g. [dev.yml](dev.yml)
```yaml
# NGINX_LOGLEVEL: debug
# command: [ "nginx-debug", "-g", "daemon off;" ]
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
