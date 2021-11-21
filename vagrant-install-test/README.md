
# Purpose

To build a simple lab using Vagrant, VirtualBox, Chocolately and PowerShell to do some test and dev.
This is to mainly verify on pemises powershell for customers or check script updates.

# Technologies

[Vagrant](https://www.vagrantup.com/ "Title")

*"Vagrant is a tool for building complete development environments. With an easy-to-use workflow and focus on automation, Vagrant lowers development environment setup time, increases development/production parity, and makes the "works on my machine" excuse a relic of the past."*

[VirtualBox](https://www.virtualbox.org "Title")

*"VirtualBox is a general-purpose full virtualizer for x86 hardware, targeted at server, desktop and embedded use. "*

[Chocolately](https://www.virtualbox.org "Title")

*"Chocolatey is a package manager for Windows (like apt-get or yum but for Windows). It was designed to be a decentralized framework for quickly installing applications and tools that you need. It is built on the NuGet infrastructure currently using PowerShell as its focus for delivering packages from the distros to your computer."*

# Setup Tools Required

1. Open PowerShell in Administrator mode.
2. Run  .\Get-ToolsForENV.ps1
3. Go have a cup of tea, this might take a while.

As well as a NAT Interface in VirtualBox you will need to add an internal only interface and take note of the IP range.

1. Go to VirtualBox management.
2. File - Preferences - Network
3. Click "Host Only Networks" tab
4. If there is no network, click + to add one

Note the IPV4 address, this is the Address format you can use for your internal network. I used 192.168.10.X. This is in my Vagrant configuration.

# Run the lab

Create a folder on a drive. I use C:\Vagrant.
In this folder I have a folder called Lab.

`mkdir c:\Vagrant\Lab`

Clone or download the zip file.

Copy the Contents of the folder into the Lab folder. Your file and folder structure should look like the following. 

```
C:\Vagrant\Lab
│   .gitignore
│   Get-ToolsForENV.ps1
│   README.md
│   Vagrantfile
└───ps1
        Install-DC.ps1
        Setup-CommonTools.ps1
        Setup-DC.ps1

```

The VagrantFile contains 1 machine. You can modify this file however you please.

1. Open an Elevated PowerShell command prompt.
2. `cd C:\Vagrant\Lab`
3. `vagrant status`

You should see the following output.

```
Current machine states:

DomainController1         not created (virtualbox)
```
Type `vagrant up`

The first time you do this it will take time to provision everything. This is because it has to grab the installation packages for Windows from the Hashicorp repository.

When it is finished you can then RDP to the IP addresses of the machines defined in the VagrantFile.

When you want to stand down the environment type `vagrant halt`.
When you want to remove the environment type `vagrant destroy`.
