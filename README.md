# vibvag
Vibrato Vagrant Test

An Apache webserver and and MySQL server.
Both running on Ubuntu AMIs spun up in AWS EC2 using Vagrant with the AWS
plugin. The multi-machine vagrantfile invokes the AWS provider for both VMs.

Pre-requisites:
- Vagrant 1.9.x installed
- vagrant-aws plugin required (https://github.com/mitchellh/vagrant-aws)
- dummy vagrant box for the vagrant-aws provider plugin 

Installing the plugin and dummy box:
```
$ vagrant plugin install vagrant-aws
$ vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
```


How to:
1. Git clone this repo
```
   $ git clone https://github.com/rixtech/vibvag
```
   
2. Set environment variables (or source from file)
```
   $ source aws-credentials
```

   * aws-credentials file looks like
```
     export AWS_KEY='your_amazon_access_key'
     export AWS_SECRET='your_amazon_secret_characters'
     export AWS_KEYNAME='name_of_keypair'
     export AWS_KEYPATH='pathto/somefile.pem'
```

3. Change into work directory
```
   $ cd vibvag
```
   
4. Provision VMs with Vagrant
```
   $ vagrant up
```
   * Strictly speaking one should use "vagrant up --provider=aws".
     However the task specified "vagrant up" as the requirement.
   
5. Browse to the URL shown in the output following the vagrant up


Comments:   
=========
The demo re-uses AWS Elastic IPs for simplicity and consistency.
If spinning up in a different VPC you will need to define the Elastic IPs
from the console or CLI and alter the IPs in the Vagrant file.

I may have misinterpreted the requirements.

The task outline says "Vagrant machine to spin up/down single machine
environment".

The assessor said "Vagrantfile doesn't reflect solution outlined in email
(one server versus 2-tier architecture)"

I have gone with 2 single tier VMs rather the a single VM with 2 tiers.

