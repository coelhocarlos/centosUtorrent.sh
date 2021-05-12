
#!/bin/bash
###############################
# UTORRENT CENTOS 12-05-2021  #
# ZER0DAWN                    #
# #############################

mkdir downloads
cd ~/downloads
#libraries
yum install -y wget glibc openssl* libgcc unzip
ln -s /usr/lib64/libcrypto.so.0.9.8e /usr/lib64/libcrypto.so.0.9.8
ln -s /usr/lib64/libssl.so.0.9.8e /usr/lib64/libssl.so.0.9.8
wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/jayvdb:/toggl/CentOS_7/x86_64/libopenssl1_0_0-1.0.2o-50.1.x86_64.rpm
sudo yum install ./libopenssl1_0_0-1.0.2o-50.1.x86_64.rpm

#Utorrent
wget https://www.utorrent.com/intl/pt/downloads/complete/track/beta/os/linux-x64-ubuntu-12-04/utserver.tar.gz
sudo tar -xvzf utserver.tar.gz -C /opt/
sudo chmod -R 755 /opt/utorrent-server-alpha-v3_3/
sudo ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver

cat << EOF > /usr/lib/systemd/system/utserver.service
[Unit]
Description=uTorrent Server (8080)
After=network.target
[Service]
WorkingDirectory=/opt/utorrent-server-alpha-v3_3
User=root
ExecStart=/opt/utorrent-server-alpha-v3_3/utserver
Restart=on-abort
[Install]
WantedBy=multi-user.target
EOF


# need libraries 1.0.0.so


chown root:root /usr/lib/systemd/system/utserver.service

sudo lsof -i -P -n | grep LISTEN
#utserver  5841     root   12u  IPv4  54350      0t0  TCP *:8080 (LISTEN)
#utserver  5841     root   13u  IPv6  54351      0t0  TCP *:8080 (LISTEN)
sudo netstat -tulpn | grep LISTEN
#tcp        0      0 0.0.0.0:8080            0.0.0.0:*               LISTEN      5841/utserver
#tcp        0      0 127.0.0.1:10000         0.0.0.0:*               LISTEN      5841/utserver
sudo ss -tulpn | grep LISTEN
#tcp    LISTEN     0      10     [::]:8080               [::]:*                   users:(("utserver",pid=5841,fd=13))

systemctl start utserver.service
echo "Browse to http://server:8080/gui and login with user admin and no password."
echo "After logging in, go to settings and setup an admin password."
echo "Want settings?  Google utserver.conf for examples..."
systemctl status utserver.service

#systemctl stop utserver.service
