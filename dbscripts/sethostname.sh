
sudo hostname $1
sudo sed -e "s/HOSTNAME=.*$/HOSTNAME=$1/" -i /etc/sysconfig/network

echo "NEED TO REBOOT: reboot"
