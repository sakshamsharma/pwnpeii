#!/usr/bin/env bash

if [ $NOASLR ]
then
    echo -n "
	kernel.randomize_va_space=0
    " >> /etc/sysctl.conf
fi

echo "Remounting /proc for preventing users from seeing each other's processes..."
sudo mount -o remount,hidepid=2 /proc

echo "Disabling read of others users' data on /tmp..."
chmod 1732 /tmp /var/tmp /dev/shm

echo "Protect your files"
chown root:root /pwnpeii
chmod 700 /pwnpeii

echo "Copying over resources"
cp /pwnpeii/mount/* /home/problemuser

echo "Changing ownership of problemuser..."
chown -R root:problemusers /home/problemuser

echo "Setting permissions..."
chmod 750 /home/problemuser
chmod 550 -R /home/problemuser/*
chmod 440 /home/problemuser/flag.txt

# For cgroups
sudo cgconfigparser -l /etc/cgconfig.conf

echo "Writing the xinetd conf file..."
echo "
service ctf
{
	disable = no
	socket_type = stream
	protocol    = tcp
	wait        = no
	user        = root
	bind        = 0.0.0.0
	per_source  = 3
	max_load    = 3.0
	cps         = 100 5
	server      = /pwnpeii/scripts/user-run.sh
	port        = 9998
}" | tee /etc/xinetd.d/ctf

echo "Adding new service to /etc/services"
echo "
ctf 9998/tcp
" >> /etc/services

# Run xinetd
/etc/init.d/xinetd start

# This runs forever
/pwnpeii/scripts/cleanup.sh
