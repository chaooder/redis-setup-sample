# Sample Redis Setup
Repository contains files to setup either Redis Standalone instance, or Redis Cluster (1 master/1 slave with automatic failover for 1 machine)

## Getting Started

### Prerequisites
You will need to download Redis binaries, see:
* Redis Quickstart: https://redis.io/topics/quickstart

For windows, you can download the binaries from https://github.com/microsoftarchive/redis/releases

### Using the Sample
* Ensure that Redis binaries are set to `PATH` environment variable

### Folders
* `conf` - Config files for starting each Redis snstance
* `data` - Data files for each Redis instance (.rdb, .aof)
* `log` - Contains logs for each Redis instance
* `script` - Helper scripts for starting / testing Redis instance
* `systemd` - Systemd .service files to start each Redis instance as a service

### Security
* Change the passwords in `conf`, `script` to a secure one

### Redis Standalone
* To start a standalone redis instance, comment out the 'Cluster related settings' in `conf/a.conf`
* Start `conf/start-redis-a.sh` (or `conf/start-redis-a.bat` for Windows)
* Test out the instance with `ping-redis-a`, you should see `PONG` in the output

### Redis Cluster
* To have 3 other machines to setup master/slave on.
  * If only 1 machine is available for POC/DEV purposes, duplicate config file in `conf` to include a total of 6 config files (since minimum instances required for Redis Cluster is 6). Edit the config files (port, directories, etc)
* Start `conf/start-redis-a.sh` & `conf/start-redis-b.sh` (or `conf/start-redis-a.bat` & `conf/start-redis-b.bat` for Windows) in all 3 VMs to start the individual Redis instances
* For Redis Cluster, if setting up across multiple machines, best practice to `bind` to a secure network interface in config file, or manage firewall to ensure only authorized external systems are able to communicate.
* Once Redis instances are up, run `script/start-redis-cluster.sh`, providing the other redis instances in the format [host:port], each separated by spaces.
* Test out cluster with `ping-redis-cluster [host] [port]`, passing in the host and port of any instance as arguments, you should see `PONG` in the output

### Systemd (For Linux)
* To allow automatic restart of Redis, `systemd` can be used.
* Edit the config files in `conf` to accomodate systemd settings
* Edit the `.service` files in `systemd`, to specify the correct user/group starting the service, and the absolute paths to the redis binaries/config/pid files
* Copy files in `systemd` to either `/etc/systemd/system` (higher system priority) or `/lib/systemd/system`
* Start systemd services with `systemctl start redis-a` (for cluster mode, `systemctl start redis-a/b` for each redis instances across machines)
* For > 2 Redis instances per machine, prepare each of the files in `conf`, `systemd`, `script` and start the instances as needed

## Built With
* [Redis](https://redis.io/) - In-Memory NoSQL KV Database

## Resources
* [Setting Up Redis](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-redis)
* [Securing Redis](https://www.digitalocean.com/community/tutorials/how-to-secure-your-redis-installation-on-ubuntu-14-04)
* [Systemd](https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files)
