To display the state of the Terraform-managed infrastructure, you can run the
```bash
terraform show
```
command in the directory containing your main.tf and state files.
This command will output the current state of the infrastructure, including the resources that have been created, their attributes, and any other relevant details.

The stage.tfvars file define variables specific to the “stage” environment. To run that specific file,
   ```bash
   terraform apply -var-file=stage.tfvars #name of the tfvars file
   ```