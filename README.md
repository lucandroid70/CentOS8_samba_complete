# CentOS8_samba_complete  Luca S. lucandroid70@gmail.com

Luca S. Script sheel, for Install samba, with file names.txt into "name" "groups" "password" 



install git with command  sudo dnf install git

git clone https://github.com/lucandroid70/CentOS8_samba_complete.git

cd CentOS8_samba_complete/

chmod +x samba_sabato.sh

sudo ./samba_sabato.sh



the file names.txt, located in this directoty "${HOME}/CentOS8_samba_complete/names.txt"

if you can change name and password in into line of script ==> names.txt

the main group are sambashareGR smbadminGR 

The directory of defauls are /samba270 and /sambadmin

This script, automatize install of samba server, create N user from file names.txt, and install Webmin

You can now login to https://localhost:10000/





# CentOS8_samba_complete  Luca S. lucandroid70@gmail.com

### Luca S. Script sheel, for Install samba, with file names.txt into "name" "groups" "password" 

# Command Main 



```sh
$ sudo dnf install git
$ git clone https://github.com/lucandroid70/CentOS8_samba_complete.git
$ cd CentOS8_samba_complete/
$ chmod +x samba_sabato.sh
$ sudo ./samba_sabato.sh
```

the file names.txt, located in this directoty "${HOME}/CentOS8_samba_complete/names.txt"

if you can change name and password in into line of script ==> names.txt

#### the main group are sambashareGR smbadminGR 

#### The directory of defauls are /samba270 and /sambadmin

This script, automatize install of samba server, create N user from file names.txt, and install Webmin

```sh
You can now login to https://localhost:10000/
```
