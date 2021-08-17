#! /bin/bash

result="`aws --profile $1 ec2 describe-images --owners $2 --filters "Name=name,Values=$3-*" "Name=tag:Type,Values=$4" "Name=tag:Environment,Values=$5" "Name=root-device-type,Values=ebs" "Name=architecture,Values=x86_64" "Name=virtualization-type,Values=hvm" --output text`"

#echo $result

if [[ -n $result ]]; then
 result='exist'
else
 result='not_exist'
fi

jq -n --arg exists ${result} '{"ami_exists": $exists }'
