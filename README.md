# terraform-jenkins-eks
Automate Jenkins deployment on Amazon EKS with Terraform. This repository provides infrastructure as code to set up a scalable, resilient CI/CD pipeline on Kubernetes, empowering efficient software development workflows.

# Deploying EKS Cluster using Terraform and Jenkins

This repository provides infrastructure as code (IaC) for deploying an Amazon Elastic Kubernetes Service (EKS) cluster using Terraform and automating the deployment process with Jenkins.

## Prerequisites

Before you begin, ensure you have the following prerequisites installed and configured:

- [Terraform](https://www.terraform.io/) (version X.X.X)
- [Jenkins](https://www.jenkins.io/) (version X.X.X)
- AWS CLI configured with appropriate credentials

## Getting Started

Follow these steps to deploy an EKS cluster:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/your-username/eks-terraform-jenkins.git
   cd eks-terraform-jenkins
   ```

2. Configure AWS credentials:

   ```bash
   aws configure
   ```

3. Update the `variables.tf` file with your preferred settings.

4. Initialize Terraform:

   ```bash
   terraform init
   ```

5. Deploy the EKS cluster:

   ```bash
   terraform apply
   ```

   Confirm the changes by typing `yes` when prompted.

6. Access Jenkins and create a new pipeline job with the provided `Jenkinsfile`.

7. Run the Jenkins pipeline to deploy and configure the EKS cluster.

## Folder Structure

- `terraform/`: Contains Terraform configuration files for EKS cluster deployment.
- `jenkins/`: Includes Jenkins pipeline script (`Jenkinsfile`) for automating the deployment process.

## Customization

Feel free to customize the Terraform configuration to suit your specific requirements. Update variables in `variables.tf` and adjust resources in the Terraform modules as needed.

## Cleanup

To destroy the EKS cluster and associated resources, run:

```bash
terraform destroy
```

Confirm the destruction by typing `yes` when prompted.

## Contributing

If you'd like to contribute to this project, please follow the [contribution guidelines](CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](LICENSE).

---

**Note:** Make sure to replace placeholders like `your-username` with your actual GitHub username and update versions accordingly.

For detailed information on EKS, Terraform, and Jenkins, refer to their official documentation:

- [Amazon EKS Documentation](https://docs.aws.amazon.com/eks/)
- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Jenkins Documentation](https://www.jenkins.io/doc/)
