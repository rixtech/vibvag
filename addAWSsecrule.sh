#!/bin/sh

# thanks to: https://oliverveits.wordpress.com 

SG=sg-dbd7d8b2
currentIP=`wget http://ipinfo.io/ip -qO -`

if [ -f lastIP ] ; then
  prevIP=`cat lastIP`
  aws ec2 revoke-security-group-ingress --group-id $SG --ip-permissions "[{\"IpProtocol\": \"tcp\", \"FromPort\": 22, \"ToPort\": 22, \"IpRanges\": [{\"CidrIp\": \"$prevIP/32\"}]}]" 
fi

aws ec2 authorize-security-group-ingress --group-id $SG --ip-permissions "[{\"IpProtocol\": \"tcp\", \"FromPort\": 22, \"ToPort\": 22, \"IpRanges\": [{\"CidrIp\": \"$currentIP/32\"}]}]" && echo $currentIP > lastIP
