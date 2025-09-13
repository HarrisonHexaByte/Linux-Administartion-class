# Software & Configurations

## Step 1: Update Packages
- Debian:
 
  sudo apt update && sudo apt upgrade -y
  ![Screenshot: debian update](../screenshots/debian_update.png)
- CentOS
sudo yum update -y
  ![Screenshot: CentOS update](../screenshots/centupdate.png)

## Step 2: install SSH Server
- Debian
  sudo apt install openssh-server -y
  sudo systemctl enable ssh --now
  ![Screenshot: debian SSH](../screenshots/debianSSH.png)
- CentOS
  sudo yum install openssh-server -y
  sudo systemctl enable sshd --now
  ![Screenshot: CentOS SSH](../screenshots/CentSSH.png)

## Step 3: Configure Networking
- open network setting in virtual box
    - change adaptor 1 to bridged adaptor
  ![Screenshot: Networksettings](../screenshots/centnetwork.png)
- Get IP adress
  - in terminal run: ip a
  ![Screenshot: Networksettings2](../screenshots/centip.png)
