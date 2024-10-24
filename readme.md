
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

## Importing Existing Resources into Terraform

If you have an existing resource (like an AWS EC2 instance) that is not yet managed by Terraform, you can import it into your Terraform state using the `terraform import` command. This is useful when you want Terraform to start managing resources that were created manually or outside of Terraform.

### Example of Importing an AWS EC2 Instance:
To import an existing EC2 instance into Terraform, you will need the EC2 instance ID and the resource address in your Terraform configuration. 

For example, to import an EC2 instance with the ID `i-0573763ef5312afd6` into a resource named `aws_instance.example` in your Terraform configuration, use the following command:

```bash
terraform import aws_instance.example i-0573763ef5312afd6
```

### Steps:
1. **Add the resource to your `main.tf` file**:
   ```hcl
   resource "aws_instance" "example" {
     # Configuration options like AMI, instance type, etc.
   }
   ```

2. **Run the `terraform import` command**:
   This tells Terraform to associate the existing instance with the configuration in your `.tf` files.

3. **Verify the Import**:
   After importing, run `terraform show` to check if the instance has been correctly imported and its state matches the existing resource.

## Conclusion

This project demonstrates how to use Terraform to manage AWS infrastructure across multiple environments using workspaces. By separating configurations using workspaces and variable files, it's easier to manage resources in different stages of deployment.
