#!/bin/bash
# =====================================================
# Part A: Linux User Management for Payment Environment
# Author: Sara
# Date: 2026-10-10
# =====================================================

# Step 1: Switch to root user to perform administrative tasks
# The hyphen (-) ensures a full login shell with root's environment
su - root

# Step 2: Create a new user 'payment_admin' with a home directory
# -m flag creates the home directory /home/payment_admin
useradd -m payment_admin

# Step 3: Set a secure password for the new user
passwd payment_admin

# Step 4: Grant sudo privileges to the user
# -aG appends the user to the 'wheel' group without removing existing groups
# 'wheel' is the admin group in Oracle Linux / RHEL
usermod -aG wheel payment_admin

# Step 5: Verify the user was created and has correct group memberships
id payment_admin

# Step 6: Test the new user by switching to them and running a sudo command
su - payment_admin
sudo whoami       # Expected output: root (confirms sudo access works)

# Step 7: Exit the user session to return to the previous user
exit
