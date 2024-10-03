#!/bin/bash
# Jus2Raisins
# 23/02/2024

if [[ $(id -un) != 'root' ]] ; then
  echo "You should run this script as root. Exiting."
  exit 1
fi

machine_name=$(hostnamectl | grep Static | cut -d' ' -f4)
echo "Machine name: ${machine_name}"

version_OS=$(uname -r)
nom_OS=$(cat /etc/os-release | head -n 1 | cut -d'"' -f2)
echo "OS : ${nom_OS} and kernel version is : ${version_OS}"

ip_Machine=$(ip a | grep inet | head -n 3 | tail -n 1 | cut -d' ' -f6)
echo "IP : ${ip_Machine}"

espace_Total=$(free -h | grep Mem | tr -s ' ' | cut -d' ' -f2)
espace_Dispo=$(free -h | grep Mem | tr -s ' ' | cut -d' ' -f7)
echo "RAM : ${espace_Dispo} memory available on : ${espace_Total}"

espace_disque_Restant=$(df -h | grep root| tr -s ' ' | cut -d' ' -f4)
echo "Disk : ${espace_disque_Restant} space left"

echo "Top 5 processes by RAM usage :"
processes=$(ps -eo command= --sort=-%mem  | head -n5 | cut -d' ' -f1)
while read process
do
  process_name=$(basename $process)
  echo "  - ${process_name}"
done <<< ${processes}

echo "Listening ports :"

while read Port
do
ports=$(echo $Port | tr -s ' ' | cut -d' ' -f5 | cut -d':' -f2)
proto=$(echo $Port | cut -d' ' -f1)
prog=$(echo $Port | cut -d'"' -f2)
echo " - $ports $proto : $prog"
done <<< "$(ss -ltun4Hp)"

echo "PATH directories :"
while read chem1
do
echo " -$chem1"
done <<< "$(echo $PATH | tr ':' '\n')"

chat=$(curl -s https://api.thecatapi.com/v1/images/search |cut -d'"' -f8)
echo "Here is your random cat (jpg file) : $chat"