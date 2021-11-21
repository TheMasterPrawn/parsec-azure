# Install Chocolately
Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

#Install Virtualbox and Vagrant, all defaults. 
choco install VirtualBox -y
choco install Vagrant -y
choco install vagrant_plugins -y
choco install packer -y
choco install vagrant-manager -y

choco list --localonly

