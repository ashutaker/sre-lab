These are the list of some problems I faced during this setup, these are specific to my hardware, OS and software choices.
## "ERROR: Ansible requires the locale encoding to be UTF-8; Detected ISO8859-1"
- Make sure `en_US.UTF-8` is present in the files below, if not then add it.
- update the locale and reboot
```
sudo echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
sudo echo "LANG=en_US.UTF-8" > /etc/locale.conf
sudo locale-gen en_US.UTF-8
# reboot
```