#!/usr/bin/env bash

# if setup script already run exit early
if [ -f "/.own_setup" ]; then
	exit 0;
fi

touch /.own_setup;

source /opt/test/.secrets.sh;

# create a group with the same gid and name as the host
groupadd -g $OWN_GID $OWN_GROUPNAME;

# create a user with the same uid and name as the host
useradd -u $OWN_UID -g $OWN_GID -M -p $OWN_PASSWORD $OWN_USERNAME;

# create samba user with
echo -e "$OWN_PASSWORD\n$OWN_PASSWORD" | smbpasswd -s -a $OWN_USERNAME

# copy the test config into conf.d directory for samba to pick up
cp /opt/test/smb.conf /etc/samba/conf.d/smb.conf
sed -i "s/%OWN_GROUPNAME%/$OWN_GROUPNAME/g" /etc/samba/conf.d/smb.conf
sed -i "s/%OWN_USERNAME%/$OWN_USERNAME/g" /etc/samba/conf.d/smb.conf
