# Find security group attachments
aws ec2 describe-network-interfaces --filters Name=group-id,Values=<group-id> --region <region> --output json

# Describe and delete SecretsManager secret
aws secretsmanager describe-secret --region us-east-1 --secret-id MyTestSecret
aws secretsmanager delete-secret --force-delete-without-recovery --region us-east-1 --secret-id MyTestSecret

# EKS:
aws eks update-kubeconfig --region us-east-1 --name production-primary

# CloudWatch Log Insights
filter StatusCode = 200 
    and ispresent(AcceptHeader.0) 
    and commitSha = "ABCD1234"
    and ClientIp = "10.0.0.0",
    and CorrelationId = "XXXXXXXX-XXX-XXXX-XXXX-XXXXXXXXXXXX"

# Helpful RDS commands
aws rds modify-db-snapshot-attribute \
    --db-snapshot-identifier "<SNAPSHOT_ID>" \
    --attribute-name "restore" \
    --values-to-add '["<ACCOUNT_ID>", "<ACCOUNT_ID>"]'
    
aws rds start-db-instance-automated-backups-replication \
	--source-db-instance-arn "<SOURCE_DB_ARN>" \
	--kms-key-id "<DESTINATION_KMS_KEY_ID>" \
	--region "us-west-1" \
	--source-region "us-east-1"

# Identify VPC dependencies
vpc="<VPC_ID>"
region="<REGION_NAME>"
aws-vault exec finance -- aws ec2 describe-vpc-peering-connections --region $region --filters 'Name=requester-vpc-info.vpc-id,Values='$vpc | grep VpcPeeringConnectionId
aws-vault exec finance -- aws ec2 describe-nat-gateways --region $region --filter 'Name=vpc-id,Values='$vpc | grep NatGatewayId
aws-vault exec finance -- aws ec2 describe-instances --region $region --filters 'Name=vpc-id,Values='$vpc | grep InstanceId
aws-vault exec finance -- aws ec2 describe-vpn-gateways --region $region --filters 'Name=attachment.vpc-id,Values='$vpc | grep VpnGatewayId
aws-vault exec finance -- aws ec2 describe-network-interfaces --region $region --filters 'Name=vpc-id,Values='$vpc | grep NetworkInterfaceId

# Identify Security Group dependencies
vpc="<VPC_ID>"
aws-vault exec prod -- aws ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='$vpc | grep InternetGatewayId
aws-vault exec prod -- aws ec2 describe-subnets --filters 'Name=vpc-id,Values='$vpc | grep SubnetId
aws-vault exec prod -- aws ec2 describe-route-tables --filters 'Name=vpc-id,Values='$vpc | grep RouteTableId
aws-vault exec prod -- aws ec2 describe-network-acls --filters 'Name=vpc-id,Values='$vpc | grep NetworkAclId
aws-vault exec prod -- aws ec2 describe-vpc-peering-connections --filters 'Name=requester-vpc-info.vpc-id,Values='$vpc | grep VpcPeeringConnectionId
aws-vault exec prod -- aws ec2 describe-vpc-endpoints --filters 'Name=vpc-id,Values='$vpc | grep VpcEndpointId
aws-vault exec prod -- aws ec2 describe-nat-gateways --filter 'Name=vpc-id,Values='$vpc | grep NatGatewayId
aws-vault exec prod -- aws ec2 describe-security-groups --filters 'Name=vpc-id,Values='$vpc | grep GroupId
aws-vault exec prod -- aws ec2 describe-instances --filters 'Name=vpc-id,Values='$vpc | grep InstanceId
aws-vault exec prod -- aws ec2 describe-vpn-connections --filters 'Name=vpc-id,Values='$vpc | grep VpnConnectionId
aws-vault exec prod -- aws ec2 describe-vpn-gateways --filters 'Name=attachment.vpc-id,Values='$vpc | grep VpnGatewayId
aws-vault exec prod -- aws ec2 describe-network-interfaces --filters 'Name=vpc-id,Values='$vpc | grep NetworkInterfaceId

# Athena Cost Reporting Query
SELECT 
  COALESCE(
    resource_tags_user_donohue_engineering_customer, 
    resource_tags_user_donohue_engineering_environment, 
    resource_tags_user_donohue_engineering_service_group, 
    resource_tags_user_donohue_engineering_service, 
    resource_tags_user_name
  ) as tag, 
  bill_billing_period_end_date as period, 
  product_product_name as product, 
  product_product_family as prod_family, 
  line_item_usage_type as item, 
  line_item_blended_cost as cost, 
  *
FROM "athenacurcfn_spend"."spend"
where (
    year = '2021' 
      AND month IN ('10','11','12')
  ) OR (
    year = '2022' 
      AND month IN ('1','2','3','4','5','6')
  )
ORDER BY resource_tags_user_cost_center, 
    bill_billing_period_end_date, 
    product_product_name, 
    product_product_family
