# Export credential
export AWS_ACCESS_KEY_ID=(your access key id)

export AWS_SECRET_ACCESS_KEY=(your secret access key)

# Create keypair yourself


# Install Ansible provisioner for Terraform
curl -sL \
  https://raw.githubusercontent.com/radekg/terraform-provisioner-ansible/master/bin/deploy-release.sh \
  --output /tmp/deploy-release.sh

chmod +x /tmp/deploy-release.sh

/tmp/deploy-release.sh -v 2.3.3

rm -rf /tmp/deploy-release.sh

# Start using your Terraform code
