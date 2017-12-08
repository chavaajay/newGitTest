aws s3 cp s3://migration-phase/Step2_InstanceProvisioning_Batch1_30Dec2017_InputFile.txt .
sleep 10
while IFS=',' read amiID InstanceCount InstanceType KeyName SG PriIP SubnetID
do
/usr/bin/aws ec2 run-instances --image-id $amiID --count $InstanceCount --instance-type $InstanceType --iam-instance-profile Name=EC2-SystemManagerRole --key-name $KeyName --security-group-ids $SG --subnet-id $SubnetID --private-ip-address $PriIP --associate-public-ip-address --tag-specifications 'ResourceType=instance,Tags=[{Key=MigrationPool,Value=WebServers-Phase1-30Dec2017}]'
done < /root/scripts/Step2_InstanceProvisioning_Batch1_30Dec2017_InputFile.txt
