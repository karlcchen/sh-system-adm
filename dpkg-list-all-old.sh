gunzip -c `ls -tr /var/log/dpkg.log.*.gz` | grep " install "
