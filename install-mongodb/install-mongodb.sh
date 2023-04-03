# Download MongoDB binary
wget https://github.com/andyshinn/alpine-pkg-mongodb/releases/download/4.4.10-r0/mongodb-4.4.10-r0.apk

# Extract the binary
tar -zxvf mongodb-4.4.10-r0.apk

# Create MongoDB directories
sudo mkdir -p /data/db /data/configdb
sudo chown -R `id -u` /data/db /data/configdb

# Move the binary to a system-wide location
sudo mv mongodb-4.4.10-r0 /opt/mongodb