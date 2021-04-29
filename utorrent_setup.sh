33 linhas lidas ]
#!/bin/bash
# Took me awhile to figure out how to install utserver on Centos 7 x86_64... Especially with the new systemd subsystem.  None of the builds I saw support it - but it will work with a couple symlinks and compa$yum install glibc libgcc openssl krb5-libs libcom_err zlib keyutils-libs libselinux glibc glibc.i[36]86 libgcc libgcc.i[36]86 openssl openssl.i[36]86 krb5-libs krb5-libs.i[36]86 libcom_err libcom_err.i[36]86 $ln -s /usr/lib/libssl.so.0.9.8e /lib/libssl.so.0.9.8
ln -s /usr/lib/libcrypto.so.0.9.8e /lib/libcrypto.so.0.9.8
mkdir /opt/utserver
wget -O /opt/utserver/utserver.tar.gz http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-ubuntu-13-04 -O utserver.tar.gz
cd /opt/
tar zxf utserver.tar.gz
mv /opt/utorrent-server-alpha-v3_3/* /opt/utserver/
#rm -rf /opt/utorrent-server-alpha-v3_3

cat << EOF > /usr/lib/systemd/system/utserver.service
[Unit]
Description=uTorrent Server (8080)
After=network.target

[Service]
WorkingDirectory=/opt/utserver
User=root
ExecStart=/opt/utserver/utserver
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF
chown root:root /usr/lib/systemd/system/utserver.service
systemctl enable utserver.service


echo "Browse to http://server:8080/gui and login with user admin and no password."
echo "After logging in, go to settings and setup an admin password."
echo "Want settings?  Google utserver.conf for examples..."
