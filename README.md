# vibvag
Vibrato Vagrant Test

An Apache webserver and and MySQL server.
Both running on Ubuntu AMIs spun up in AWS EC2 using Vagrant with the AWS plugin.

Pre-requisites:
- Vagrant 1.9.x installed
- vagrant-aws plugin required (https://github.com/mitchellh/vagrant-aws)
- dummy vagrant box for the vagrant-aws provider plugin 

Installing the plugin and dummy box:
$ vagrant plugin install vagrant-aws
$ vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box


How to:
1. git clone this repo
   $ git clone https://github.com/rixtech/vibvag
   
2. change into work directory
   $ cd vibvag
   
3. provision VMs with Vagrant
   $ vagrant up
   
4. browse to the URL shown in the output following the vagrant up

   

