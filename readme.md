
# Terraform AWS Infrastructure with Workspaces

This Terraform project sets up a basic AWS infrastructure with the use of Terraform workspaces to manage different environments.

## Project Structure

```bash
.
├── .terraform/
├── modules/
│   └── ec2-instance/
│       ├── main.tf
│       └── variables.tf
├── terraform.tfstate.d/
│   ├── dev/
│   │   └── terraform.tfstate
│   ├── prod/
│   ├── stage/
├── .gitignore
├── main.tf
├── readme.md
├── terraform.tfvars
└── stage.tfvars
```

### Key Files:
- **modules/ec2-instance/main.tf**: Contains the EC2 instance configuration and associated variables.
- **variables.tf**: Defines variables used for managing different instance types across workspaces.
- **main.tf**: The primary Terraform configuration that sets up the VPC, subnet, internet gateway, security group, and EC2 instance.
- **terraform.tfvars**: A sample variables file to define environment-specific configurations.
- **stage.tfvars**: A file defining variables specific to the "stage" environment.

## Terraform Workspaces

This project utilizes Terraform workspaces to manage different environments like `dev`, `prod`, and `stage`.

- To create a new workspace:
  ```bash
  terraform workspace new <workspace_name>
  ```

- To select an existing workspace:
  ```bash
  terraform workspace select <workspace_name>
  ```

- To show the current workspace:
  ```bash
  terraform workspace show
  ```

## Commands to Deploy

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Apply Configuration for a Specific Workspace**:
   For example, to apply the configuration using variables from the `stage.tfvars` file:
   ```bash
   terraform apply -var-file=stage.tfvars
   ```

3. **Show Current Infrastructure State**:
   To display the state of the Terraform-managed infrastructure:
   ```bash
   terraform show
   ```

4. **Destroy the Infrastructure**:
   If you want to remove the infrastructure managed by Terraform:
   ```bash
   terraform destroy
   ```

## Importing Existing Resources into Terraform

If a resource, such as an EC2 instance or S3 bucket, already exists and you want Terraform to manage it, use the `terraform import` command.

Example:
```bash
terraform import aws_instance.example i-0573763ef5312afd6
```
This imports an existing AWS EC2 instance with the ID `i-0573763ef5312afd6` into your Terraform configuration, associating it with the resource `aws_instance.example`.

## Updating Terraform State with External Changes

If resources in your infrastructure are changed outside of Terraform (e.g., using the AWS Console), you can update your Terraform state to reflect those changes without applying any additional configuration changes.

- Run the `terraform refresh` command to reconcile the state:
   ```bash
   terraform refresh
   ```
   This command updates the Terraform state file with the actual state of the resources.

After running `terraform refresh`, Terraform will compare its state file with the real-world infrastructure, making sure the state file matches the current configuration of your resources. No changes will be made to the infrastructure; this only updates Terraform's understanding of it.

## EC2 Instance

The EC2 instance is created using a module and includes the following:
- **AMI**: Amazon Linux 2 AMI (ami-0b5eea76982371e91)
- **Instance Type**: This varies by workspace (e.g., `t3.micro` for `dev`, `t3.medium` for `prod`).
- **Security Group**: Allows inbound SSH and HTTP traffic, and outbound traffic on all ports.

### Example EC2 Module Usage:
```hcl
module "ec2_instance" {
  source = "./modules/ec2-instance"
  ami_value = var.ami_value
  instance_type_value = lookup(var.instance_type_value, terraform.workspace, "t3.micro")
}
```

## Conclusion

This project demonstrates how to use Terraform to manage AWS infrastructure across multiple environments using workspaces. By separating configurations using workspaces and variable files, it's easier to manage resources in different stages of deployment.
