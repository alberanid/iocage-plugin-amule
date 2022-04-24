#!/bin/sh

# Create user 'amule'
pw add user -n aMule -c aMule -s /bin/csh -m
# Create default configuration in ~aMule/.aMule/
su -l aMule -c "amuled --reset-config"

# Enable the service
sysrc -f /etc/rc.conf amuled_enable="YES"

# Allow external connections
sed -I .bak 's/.*AcceptExternalConnections=.*/AcceptExternalConnections=1/' /home/aMule/.aMule/amule.conf

# Set default password
pwd="$(openssl rand -base64 18)"
pwdhash="$(echo -n "$pwd" | md5 | cut -d ' ' -f 1)"
sed -I .bak "s/^ECPassword=$/ECPassword=${pwdhash}/" /home/aMule/.aMule/amule.conf

# Enabled amuleweb
sed -I .bak 's/^Enabled=.*$/Enabled=1/' /home/aMule/.aMule/amule.conf

# Set amuleweb passwords
webpwd="$(openssl rand -base64 18)"
webpwdhash="$(echo -n "$webpwd" | md5 | cut -d ' ' -f 1)"
sed -I .bak "s/^Password=$/Password=${webpwdhash}/" /home/aMule/.aMule/amule.conf
webpwdlow="$(openssl rand -base64 18)"
webpwdlowhash="$(echo -n "$webpwdlow" | md5 | cut -d ' ' -f 1)"
sed -I .bak "s/^PasswordLow=$/PasswordLow=${webpwdlowhash}/" /home/aMule/.aMule/amule.conf

su -l aMule -c "amuleweb --write-config"

echo "aMule password: $pwd" >> /root/PLUGIN_INFO
echo "aMule web password: $webpwd" >> /root/PLUGIN_INFO
echo "aMule web low password: $webpwdlow" >> /root/PLUGIN_INFO

# Start the service
service amuled start
