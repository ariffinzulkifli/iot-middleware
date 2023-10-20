```
   __  ___     _                   __    ______        __             __          _       
  /  |/  /_ __(_)__ _  _____ ___  / /_  /_  __/__ ____/ /  ___  ___  / /__  ___ _(_)__ ___
 / /|_/ / // / / _ \ |/ / -_) _ \/ __/   / / / -_) __/ _ \/ _ \/ _ \/ / _ \/ _ `/ / -_|_-<
/_/  /_/\_, /_/_//_/___/\__/_//_/\__/   /_/  \__/\__/_//_/_//_/\___/_/\___/\_, /_/\__/___/
       /___/                                                              /___/           
ai.iot.cloud.technology.training.trading =================================================

Ts. Mohamad Ariffin Zulkifli
ariffin@myduino.com
```

# Docker IoT Middleware

This repository contains a skeleton to setup remote server to become a powerful IoT middleware along side with open-source server side applications below using [Docker Compose](https://docs.docker.com/compose/):
- [Mosquitto](https://mosquitto.org/) for MQTT protocols
- [Node-RED](https://nodered.org/) for Javascript low-code flow-based flow programming
- [InfluxDB](https://www.influxdata.com/) for time series database
- [MySQL](https://www.mysql.com/) for SQL database
- [Adminer](https://www.adminer.org/) for SQL database management system
- [Grafana](https://grafana.com/) for interactive dashboard and
- [Chirpstack](https://www.chirpstack.io/) for LoRaWAN Network Server

In Docker, each applications above is containerized into single image and it is readily available in [Docker Hub](https://hub.docker.com/). For example, everything you need to host Node-RED in a server including NodeJS and other libraries or dependencies is containerized as [nodered/node-red](https://hub.docker.com/r/nodered/node-red) image.

IoT middleware require several applications to work together as you seen as listed above. We need to use Docker Compose to define and running multi-container Docker images. It simplifies the process of managing and orchestrating multiple Docker containers that work together to form a single application in a server.

Docker Compose allows you to define your entire application stack in a single, easy-to-read configuration file called `docker-compose.yml`. In this file, you specify which containers should run, how they should be configured, and how they should connect to each other.

In this repository contain `docker-compose.yml` with definition of stack of applications stated above so we can easily setup IoT middleware.

**Note:** Please use this `docker-compose.yml` file as a starting point for training and testing
but keep in mind that for production usage it might need modifications, especially security.

## Directory layout

* `docker-compose.yml`: the docker-compose file containing the services
* `configuration/chirpstack`: directory containing the ChirpStack configuration files
* `configuration/chirpstack-gateway-bridge`: directory containing the ChirpStack Gateway Bridge configuration
* `configuration/mosquitto`: directory containing the Mosquitto (MQTT broker) configuration
* `configuration/nodered`: directory containing the Node-RED configuration
* `configuration/postgresql/initdb/`: directory containing PostgreSQL initialization scripts
* `lorawan-devices/`: directory for LoRaWAN devices

## Requirements

Before using this `docker-compose.yml` file, make sure you have a remote server by cloud hosting service like [GBCloud](https://billing.gbcloud.net/aff.php?aff=87) and [Docker](https://www.docker.com/community-edition) installed in the server.

### Create Account on GBCloud

This guide will guide you through the steps to create account on GBCloud.

1. Click the `Create account` link on [GBCloud](https://billing.gbcloud.net/aff.php?aff=87) login page.
2. Fill in your `Personal Information`, `Billing Address`, `Additional Information` and `Account Security`.
3. Check the `I have read and agree to the Terms of Service`. and click the `Register` button.

### Remote SSH Ubuntu Server

This guide will guide you through the steps to remote SSH your Ubuntu server.

1. Open Terminal on your PC.

**Note:** You can use any suitable software such as [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.3), [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html), [Cmder](https://github.com/cmderdev/cmder), etc.

2. Use the SSH command to connect to the remote server.

**Note:** change the `ip-address` with your server ip-address.
```bash
ssh root@ip-address
```
**Note:** When you attempt to connect for the first time, SSH will display the authenticity message you provided. It shows the server's fingerprint, which is a unique identifier for the server's SSH key. You need to verify this fingerprint to ensure you're connecting to the correct server. Type in `yes` to continue.

```bash
The authenticity of host 'ip-address (ip-address)' can't be established.
ED25519 key fingerprint is SHA256:oUuTnMQM2qCp7Oqip8gBpclMRBJFbL/hbQR5kbQnNOk.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? 
```

3. After confirming the authenticity of the server, SSH will prompt you to enter your password to log in.
```bash
root@ip-address's password:
```

If you provided the correct credentials, you should now be logged into the remote server, and you can start using it. You'll see the Ubuntu server terminal as below.

```
Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-52-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Oct 17 19:21:02 +08 2023

  System load:           0.1962890625
  Usage of /:            3.7% of 48.27GB
  Memory usage:          10%
  Swap usage:            0%
  Processes:             95
  Users logged in:       0
  IPv4 address for eth0: ipv4-ipaddress
  IPv6 address for eth0: ipv6-ipaddress


0 updates can be applied immediately.


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

Last login: Tue Nov  1 15:31:57 2022 from 104.208.107.150
root@iot-middleware:~# 
```

### Docker Installation

This guide will walk you through the steps to install Docker on Ubuntu.

1. Update the package list to ensure you have the latest information about available packages.
```bash
sudo apt update
```

2. Install the necessary packages and dependencies for Docker.
```bash
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

3. Add Docker's GPG key to your system.
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

4. Add the Docker repository to your system's sources list.
```bash
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

5. Update the package list once more to include Docker repository information.
```bash
sudo apt update
```

6. Check the available Docker packages and their versions.
```bash
apt-cache policy docker-ce
```

You'll see the output like below, although the version number for Docker may be different:
```
docker-ce:
  Installed: (none)
  Candidate: 5:20.10.14~3-0~ubuntu-jammy
  Version table:
     5:20.10.14~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
     5:20.10.13~3-0~ubuntu-jammy 500
        500 https://download.docker.com/linux/ubuntu jammy/stable amd64 Packages
```

7. Install Docker using the following command.
```bash
sudo apt install docker-ce
```

8. Check the status of the Docker service to verify that it's running.
```bash
sudo systemctl status docker
```

You'll see the output like below, showing that the service is active and running:
```
Output
● docker.service - Docker Application Container Engine
     Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
     Active: active (running) since Fri 2022-04-01 21:30:25 UTC; 22s ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
   Main PID: 7854 (dockerd)
      Tasks: 7
     Memory: 38.3M
        CPU: 340ms
     CGroup: /system.slice/docker.service
             └─7854 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```
Hold `Ctrl + C` on keyboard to exit the status back to terminal prompt.

### Docker Compose Installation

Once Docker successfully installed, let's walk through the steps to install Docker Compose.

1. Make sure the directory where Docker Compose should be installed exists. This command creates the necessary directory if it doesn't exist.
```bash
mkdir -p ~/.docker/cli-plugins/
```

2. Download the Docker Compose binary to the specified directory.
```bash
curl -SL https://github.com/docker/compose/releases/download/v2.23.0/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
```

3. Make the downloaded Docker Compose binary executable.
```bash
chmod +x ~/.docker/cli-plugins/docker-compose
```

4. Check the Docker Compose version to verify that it's installed correctly.
```bash
docker compose version
```

You’ll see output like below, showing that Docker Compose is successfully installed with stated version:
```
Output
Docker Compose version v2.22.0
```

## Running Docker Compose

1. Clone this repository into your server using the `git clone` command.
```bash
git clone https://github.com/ariffinzulkifli/iot-middleware.git
```

2. Change your working directory to the cloned repository directory.
```bash
cd ~/iot-middleware
```

3. Inspect the contents of the Docker Compose file `docker-compose.yml` to understand the services and configurations defined in it.
```bash
cat docker-compose.yml
```

You’ll see output like below.
```
version: "3"

services:
  nodered:
    image: nodered/node-red:latest
    restart: unless-stopped
    ports:
      - 1880:1880
    volumes:
      - ./configuration/nodered/settings.js:/data/settings.js
    networks:
      - iotstack
```

4. Launch the Docker Compose services defined in the `docker-compose.yml` file in detached mode.
```bash
docker compose up -d
```
Wait until all containers is successfully `Started` like below.

```
[+] Running 13/13
 ✔ Network iot-middleware_iotstack                                    Created            0.1s 
 ✔ Container iot-middleware-mysql-1                                   Started            0.2s 
 ✔ Container iot-middleware-postgres-1                                Started            0.2s 
 ✔ Container iot-middleware-grafana-1                                 Started            0.2s 
 ✔ Container iot-middleware-nodered-1                                 Started            0.2s 
 ✔ Container iot-middleware-mosquitto-1                               Started            0.2s 
 ✔ Container iot-middleware-adminer-1                                 Started            0.2s 
 ✔ Container iot-middleware-redis-1                                   Started            0.2s 
 ✔ Container iot-middleware-influxdb-1                                Started            0.2s 
 ✔ Container iot-middleware-chirpstack-gateway-bridge-basicstation-1  Started            0.1s 
 ✔ Container iot-middleware-chirpstack-gateway-bridge-1               Started            0.0s 
 ✔ Container iot-middleware-chirpstack-1                              Started            0.0s 
 ✔ Container iot-middleware-chirpstack-rest-api-1                     Started            0.0s 
```

5. Verify that the Docker Compose containers are running using the following command.
```bash
docker compose ps
```

6. View the logs of the Docker Compose containers to monitor their output and any potential issues.
```bash
docker compose logs
```

## Usage

After all the Docker containers have been sucessfully initialized and started, you should be able
to access the applications in your browser.

**Note:** change the `ip-address` with your server ip-address.

- Node-RED http://`ip-address`:1880
  - username: admin
  - password: password
- InfluxDB http://`ip-address`:8086
  - username: admin
  - password: password
- Adminer http://`ip-address`:8060
  - username: root
  - password: password
- Grafana http://`ip-address`:3000
  - username: admin
  - password: password
- Chirpstack http://`ip-address`:8080
  - username: admin
  - password: admin
- Chirpstack REST API http://`ip-address`:8090

Mosquitto MQTT broker can be access by it's configuration below:
- host: `ip-address`
- protocol: TCP
  - port: 1883
- protocol: Websockets
  - port: 9001
- username: admin
- password: password

MySQL database can be access by it's configuration below:
- host: `ip-address`
- port: 3306
- username: root
- password: password
