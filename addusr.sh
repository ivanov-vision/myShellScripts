#!/usr/bin/env bash
# Script to add a user to Linux system
echo "Ctrl + C if need to cancel the operation"
if [ $(id -u) -eq 0 ]; then
  read -p "Enter username : " username
  read -p "Enter password : " pass1
  read -p "Verify password : " pass2
  if [ $pass1 = $pass2 ]; then
    password=$pass1
  else
    echo "Wrong Password"
    exit
  fi
  read -p "Enter Path to SSH Key : " path
  egrep "^$username" /etc/passwd >/dev/null
  if [ $? -eq 0 ]; then
    echo $username "exists!"
    exit 1
  else
    pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
    useradd -m -p $pass $username
    [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
    mkdir /home/$username/.ssh/
    mkdir /home/$username/.ssh/authorized_keys
    chown -R $username:$username /home/$username 
    chmod -R 700 /home/$username
    cp $path /home/$username/.ssh/authorized_keys/ 2>/dev/null
    if [ $? -eq 0 ]; then
      echo "Key Moved and Privileges Edited"
    else
      echo "Error with Key, Please Move Manually."
    fi
  fi
else
  echo "Only root may add a user to the system"
  exit 2
fi
