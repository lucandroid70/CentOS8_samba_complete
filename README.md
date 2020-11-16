# CentOS8_samba_complete  Luca S. lucandroid70@gmail.com

### Luca S. Script sheel, for Install samba, with file names.txt into "name" "groups" "password" 

# Command Main 



```sh
$ sudo dnf install git -y
$ sudo -s
# cd ~
# git clone https://github.com/lucandroid70/CentOS8_samba_complete.git
# cd CentOS8_samba_complete/
# chmod +x samba_sabato.sh
# sudo ./samba_sabato.sh
```

the file names.txt, located in this directoty "${HOME}/CentOS8_samba_complete/names.txt"

if you can change name and password in into line of script ==> names.txt

#### the main group are sambashareGR smbadminGR 

#### The directory of defauls are /samba270 and /sambadmin

#### don't problem for error "ERROR: 'ldap admin dn' not defined! Please check your smb.conf" is normal! 

This script, automatize install of samba server, create N user from file names.txt, and install Webmin

If you not see samba-server launch this comand: 
sudo setenforce 0     ====>      for selinux permissive


#### webmin 
You can now login to https://IP-OR-FQDN-NAME-YOUR-CENTOS:10000/


##### for selinux under line setting 

sudo setsebool -P samba_enable_home_dirs on

sudo chcon -t samba_share_t /samba270

sudo setsebool -P samba_export_all_rw on
