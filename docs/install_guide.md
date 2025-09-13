# Installing CentOS and Debian on VirtualBox

## Step 1: Download ISOs and virtual box
- Virtal box download: https://www.virtualbox.org/wiki/Downloads
  ![Screenshot: ISO Downloads2](virtualbox_download.png)
- CentOS Stream: https://www.centos.org/download/
  ![Screenshot: ISO Downloads2](cent_download.png)
- Debian: https://www.debian.org/distrib/
  ![Screenshot: ISO Downloads1](debian_download.png)


---

## Step 2: Create Virtual Machines
- Open VirtualBox → *New*
- Example settings:
  - **Type:** Linux
  - **Version:** Red Hat (64-bit) for CentOS, Debian (64-bit) for Debian
  - **Memory:** 2 GB
  - **Disk:** 20 GB

![Screenshot: VM Creation](../screenshots/vm_creation.png)

---

## Step 3: Install the OS
- Attach ISO in **Settings → Storage**
- Follow installer prompts:
  - Select language
  - Accept default disk settings
  - Create root + user accounts

![Screenshot: Installer](../screenshots/installer.png)

---

## Step 4: First Boot
- Eject ISO, reboot
- Log in with user credentials

![Screenshot: Login Screen](../screenshots/login.png)

---

✅ You now have CentOS and Debian VMs installed in VirtualBox.
