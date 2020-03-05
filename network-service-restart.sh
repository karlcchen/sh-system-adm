#wq old method 
# sudo service networking restart
#

# replaced with proper interface names  
# sudo ifdown --force enp0s3 lo && ifup -a
#

sudo systemctl unmask networking
sudo systemctl enable networking
sudo systemctl restart networking

# sudo systemctl restart networking.service
./network-service-status.sh
