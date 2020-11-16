#!/bin/sh

sudo dnf update -y
sudo setenforce 0
sudo dnf install bash-completion -y
sudo dnf install perl perl-Net-SSLeay openssl perl-Encode-Detect wget -y
#sudo dnf install perl perl-Net-SSLeay openssl perl-Encode-Detect wget -y
#sudo dnf install samba samba-client samba-common -y
sudo dnf install samba samba-common samba-client -y
#sudo dnf install policycoreutils-python-utils -y

sudo mv /etc/samba/smb.conf /etc/samba/_smb.conf

sudo cat >> /etc/samba/smb.conf << EOF
[global]
workgroup = WORKGROUP
server string = Samba Server %v
netbios name = SECTOR70
security = user
map to guest = bad user
dns proxy = no
client min protocol = SMB2
client max protocol = SMB3
# Private shared directory
[admin]
    path = /sambadmin
    browseable = yes
    read only = no
    force create mode = 0660
    force directory mode = 2770
    valid users = @smbadminGR
[users]
    path = /samba270
    browseable = yes
    read only = no
    force create mode = 0660
    force directory mode = 2770
    valid users = @sambashareGR @smbadminGR
EOF



sudo systemctl start smb.service
sudo systemctl start nmb.service
sudo systemctl enable smb.service
sudo systemctl enable nmb.service




sudo mkdir -p /samba270
sudo mkdir -p /sambadmin
#sudo mkdir /samba270
#sudo mkdir /sambadmin

sudo groupadd sambashareGR
sudo groupadd smbadminGR



#############################selinux#############################################

sudo setsebool -P samba_enable_home_dirs on
sudo chcon -t samba_share_t /samba270
sudo setsebool -P samba_export_all_rw on

#############################selinux#############################################







NEW_USERS="${HOME}/CentOS8_samba_complete/names.txt"
#NEW_USERS="/home/luca/names.txt"

cat ${NEW_USERS} | \
while read USER GROUP SMBPASS ; do
   groupadd ${GROUP} 2> /dev/null
   #useradd -m -D /samba270/${USER} -g ${GROUP}
   #adduser ${USER} -g ${GROUP}
   adduser -m -d /samba270/${USER} -s /sbin/nologin ${USER}  -g ${GROUP}

   (echo $SMBPASS; echo $SMBPASS) | passwd --stdin ${USER} > /dev/null
   echo Added user ${USER}
   smbpasswd -e ${USER} -w ${SMBPASS} > /dev/null
   (echo $SMBPASS; echo $SMBPASS) | smbpasswd -a ${USER}
   echo -e "${USER} = ${USER}" >> /etc/samba/smbusers
   smbpasswd -e ${USER}
   chown -R ${USER}:${GROUP} /samba270
   chmod -R 2770 /samba270/${USER}
   chgrp -R sambashareGR /samba270
done


#sudo chmod -R 2770 /sambadmin
#sudo chgrp -R sambashareGR /samba270


##################################################### SELINUX OFF-ON ################################################
#sudo setsebool -P samba_export_all_ro=1 samba_export_all_rw=1
#sudo semanage fcontext -a -t samba_share_t "/samba270(/.*)?"
#sudo restorecon /samba270
#sudo setsebool -P samba_export_all_ro=1 samba_export_all_rw=1
#sudo semanage fcontext -a -t samba_share_t "/sambadmin(/.*)?"
#sudo restorecon /sambadmin
##################################################### SELINUX OFF-ON ################################################


#sudo setsebool -P samba_enable_home_dirs on
#sudo chcon -t samba_share_t /samba270
#sudo setsebool -P samba_export_all_rw on




#sudo chcon -t samba_share_t /sambadmin
#sudo chcon -t samba_share_t /samba270
#sudo chcon -R -t samba_share_t /samba270
#sudo reboot
#sudo firewall-cmd --permanent --zone=public --add-service=samba
#sudo firewall-cmd --zone=public --add-service=samba

sudo firewall-cmd --add-service=samba --zone=public --permanent
sudo firewall-cmd --reload


sudo systemctl reload smb.service nmb.service
sudo systemctl restart smb.service nmb.service
#sudo reboot

sudo dnf update -y
dnf install perl perl-Net-SSLeay openssl perl-Encode-Detect wget -y


sudo touch /etc/yum.repos.d/webmin.repo


sudo cat >> /etc/yum.repos.d/webmin.repo << EOF
[Webmin]
name=Webmin Distribution Neutral
mirrorlist=https://download.webmin.com/download/yum/mirrorlist
enabled=1
EOF




sudo wget http://www.webmin.com/jcameron-key.asc && sudo rpm --import jcameron-key.asc

#read -p "Press enter to continue"



sudo dnf install webmin -y



firewall-cmd --zone=public --add-port=10000/tcp --permanent
firewall-cmd --reload

sudo reboot
