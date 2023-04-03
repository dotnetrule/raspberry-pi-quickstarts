To install MongoDB on a Raspberry Pi and make it accessible to your network, follow these steps:

Update and upgrade the system:
First, ensure your Raspberry Pi is up to date by running the following commands:

```bash
sudo apt-get update
sudo apt-get upgrade
```

Install dependencies:
Next, install the necessary dependencies for MongoDB:

```bash
sudo apt-get install -y libssl-dev libcurl4-openssl-dev libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libboost-thread-dev
```

## Download and install MongoDB: ##
MongoDB does not provide official packages for Raspberry Pi, but you can use unofficial builds. One such build is available from "andyshinn" on GitHub.
Or run `install-mongodb.sh`
```bash
# Download MongoDB binary
wget https://github.com/andyshinn/alpine-pkg-mongodb/releases/download/4.4.10-r0/mongodb-4.4.10-r0.apk

# Extract the binary
tar -zxvf mongodb-4.4.10-r0.apk

# Create MongoDB directories
sudo mkdir -p /data/db /data/configdb
sudo chown -R `id -u` /data/db /data/configdb

# Move the binary to a system-wide location
sudo mv mongodb-4.4.10-r0 /opt/mongodb
```
Add MongoDB to your PATH by editing your ~/.bashrc file:

```bash
echo 'export PATH="/opt/mongodb/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Create a systemd service:
To automatically start MongoDB when your Raspberry Pi boots, create a systemd service file:

```bash
sudo nano /etc/systemd/system/mongodb.service
```
Paste the following content into the file:

```makefile
[Unit]
Description=MongoDB Database Server
After=network.target

[Service]
User=pi
ExecStart=/opt/mongodb/bin/mongod --config /etc/mongod.conf
ExecReload=/bin/kill -s HUP $MAINPID
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
Save and exit the file.
```

## Configure MongoDB: ##
Now, create a configuration file for MongoDB:

```bash
sudo nano /etc/mongod.conf
```
Paste the following content into the file:

```yaml
storage:
  dbPath: /data/db
  journal:
    enabled: true
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
net:
  port: 27017
  bindIp: 0.0.0.0
Here, bindIp: 0.0.0.0 allows connections from any IP address. You can replace 0.0.0.0 with a specific IP address or a comma-separated list of IP addresses to allow connections only from specific devices.
```
Save and exit the file.

## Start and enable MongoDB: ##
Enable and start the MongoDB service:

```bash
sudo systemctl enable mongodb
sudo systemctl start mongodb
```
Check the MongoDB status:
Verify that MongoDB is running:

```bash
sudo systemctl status mongodb
```
If everything is set up correctly, you should see a message indicating that the service is active and running.
