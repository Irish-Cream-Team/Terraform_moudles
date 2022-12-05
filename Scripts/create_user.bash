# Get user arguments
NEW_USER=$1
echo "Creating12 user $NEW_USER"
# PUBLIC_KEY=$2

# # Create user
# adduser $NEW_USER --gecos 'First Last,RoomNumber,WorkPhone,HomePhone' --disabled-password

# # Create .ssh directory and add public-ssh-key to authorized_keys file
# mkdir -p /home/$NEW_USER/.ssh
# chmod 777 /home/$NEW_USER/.ssh
# # touch /home/$NEW_USER/.ssh/authorized_keys
# echo " $PUBLIC_KEY" >> /home/$NEW_USER/.ssh/authorized_keys

# # Change permissions
# chmod 644 /home/$NEW_USER/.ssh/authorized_keys
# chmod 700 /home/$NEW_USER/.ssh
# chown -R $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh

# # Add user to sudoers without password
# echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$NEW_USER-user%