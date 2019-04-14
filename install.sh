#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# ------------------------------ #
#  move dotfiles and db          #
# ------------------------------ #
mkdir ~/.env
cp ./dotfiles/.bashrc ~
cp ./dotfiles/.vimrc ~
mkdir -p ~/.config/terminator
cp ./dotfiles/terminator-config ~/.config/terminator/config
cp ./db.txt ~/.env

# ------------------------------ #
#  basic setup                   #
# ------------------------------ #
apt clean && apt update && apt upgrade -y
apt install -y terminator git python-setuptools

# ------------------------------ #
#  tools                         #
# ------------------------------ #

# metasploit
apt install metasploit-framework

# impacket
cd /opt
git clone https://github.com/CoreSecurity/impacket.git
cd /opt/impacket && python setup.py install

# fuzzdb
cd /opt
git clone https://github.com/fuzzdb-project/fuzzdb.git

# empire (run setup manually)
cd /opt
git clone https://github.com/PowerShellEmpire/Empire.git

# veil
cd /opt
git clone https://github.com/Veil-Framework/Veil.git
./config/setup.sh --force --silent

# powersploit
cd /opt
git clone https://github.com/PowerShellMafia/PowerSploit.git

# searchsploit
apt -y install exploitdb exploitdb-papers exploitdb-bin-sploits
searchsploit -u

# windows local enumration
cd /opt
git clone https://github.com/bitsadmin/miscellaneous
mv miscellaneous localrecon.cmd 

# windows exploit suggester
cd /opt
git clone https://github.com/GDSSecurity/Windows-Exploit-Suggester
pip install xlutils
cd /opt/Windows-Exploit-Suggester
python windows-exploit-suggester.py --update
cd /opt
git clone https://github.com/bitsadmin/wesng
cd /opt/wesng
python wes.py --update

# nix exploit/enumration
cd /opt
git clone https://github.com/InteliSecureLabs/Linux_Exploit_Suggester
git clone https://github.com/pentestmonkey/unix-privesc-check

# oletools
apt install python-oletools

# ------------------------------ #
#  finish up                     #
# ------------------------------ #
source ~/.bashrc
