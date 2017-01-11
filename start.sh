#!/usr/bin/env bash

if [ $NOASLR ]
then
    echo -n "
	kernel.randomize_va_space=0
    " >> /etc/sysctl.conf
fi

echo "Remounting /proc for preventing users from seeing each other's processes..."
mount -o remount,hidepid=2 /proc

echo "Disabling read of others users' data on /tmp..."
chmod 1732 /tmp /var/tmp /dev/shm

echo "Changing ownership of problemuser..."
chown -R root:problemusers /home/problemuser

echo "Copying over resources"
cp /pwnpeii/mount/* /home/problemuser

echo "Setting permissions..."
chmod 750 /home/problemuser
chmod 550 -R /home/problemuser/*
chmod 440 /home/problemuser/flag.txt

# For cgroups
cgconfigparser -l /etc/cgconfig.conf

echo "Writing the xinetd conf file..."
echo "
service pwneii_ctf
{
	disable = no
	socket_type = stream
	protocol    = tcp
	wait        = no
	user        = problemuser
	bind        = 0.0.0.0
	server      = /pwnpeii/user-run.sh
	type        = UNLISTED
	port        = 9998
}" | tee /etc/xinetd.d/pwneii_ctf

# Run xinetd
sudo systemctl start xinetd

# This runs forever
./scripts/cleanup.sh
