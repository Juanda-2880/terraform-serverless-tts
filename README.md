# Serverless Book Narrator (AWS Polly + Terraform)

![AWS](https://img.shields.io/badge/AWS-Serverless-orange)
![Terraform](https://img.shields.io/badge/Infrastructure%20as%20Code-Terraform-purple)
![Python](https://img.shields.io/badge/Runtime-Python%203.9-blue)

---

## Project Overview

This project implements a **serverless Text-to-Speech (TTS) solution** that converts text input into high-quality MP3 audio files using **Amazon Polly (Neural Engine)**.

All cloud resources are provisioned using **Terraform (Infrastructure as Code)**, ensuring the deployment is reproducible, secure, and easy to manage. The solution showcases an event-driven workflow where an AWS Lambda function handles text synthesis and stores the generated audio files in Amazon S3.

---

## Architecture Overview

The solution follows a fully managed, event-driven serverless architecture:


<img width="1390" height="628" alt="Blank diagram (2)" src="https://github.com/user-attachments/assets/fc4cdea5-97c4-4fec-a868-6bebfa3c4660" />


1. **Invocation**
   A user triggers the Lambda function by providing a JSON payload containing the text to be synthesized.

2. **Compute**
   An **AWS Lambda** function written in Python (Boto3) processes the request and sends the text to Amazon Polly.

3. **Text-to-Speech (AI/ML)**
   **Amazon Polly (Neural Engine)** converts the text into an audio stream.

4. **Storage**
   The generated audio stream is saved as an `.mp3` file in an **Amazon S3** bucket.

---

## Technologies and Services

* **Infrastructure as Code:** Terraform
* **Cloud Provider:** AWS
* **Compute:** AWS Lambda (Python 3.9)
* **AI/ML Service:** Amazon Polly (Neural Engine)
* **Storage:** Amazon S3
* **Security:** AWS IAM (least-privilege roles and policies)

---

## Project Structure

```text
.
├── aws/                  # Terraform infrastructure code
│   ├── main.tf           # Provider configuration
│   ├── lambda.tf         # Lambda function and packaging logic
│   ├── iam.tf            # IAM roles and policies
│   ├── storage.tf        # S3 bucket configuration
│   └── variables.tf      # Project variables (region, naming)
├── src/                  # Application source code
│   └── index.py          # Lambda function logic (Python)
└── README.md             # Project documentation
```

---

## Prerequisites

Before deploying the project, ensure you have:

* Terraform installed (v1.0 or higher)
* AWS CLI installed and configured with valid credentials
* An active AWS account

---

## Deployment Guide

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR-USERNAME/aws-polly-terraform-narrator.git
cd aws-polly-terraform-narrator
```

### 2. Initialize Terraform

Navigate to the infrastructure directory and initialize Terraform:

```bash
cd aws
terraform init
```

### 3. Plan and Apply

Review the execution plan and deploy the infrastructure:

```bash
terraform plan
terraform apply --auto-approve
```

**Note:** The default AWS region is set to `us-east-1` to ensure compatibility with Amazon Polly's Neural Engine.

---

## Testing the Function

After deployment, the Lambda function can be tested using the AWS Console or the AWS CLI.

### Sample Test Event

```json
{
  "text": "Hello! This is a demonstration of the Serverless Book Narrator built with Terraform."
}
```

### Testing via AWS Console

1. Open the AWS Lambda Console.
2. Select the deployed function (for example, `polly-narrator-function`).
3. Navigate to the **Test** tab.
4. Paste the JSON payload above and execute the test.
5. Review the logs and confirm that the MP3 file was created in the S3 bucket.

---

## Cleanup

To avoid unexpected AWS charges, destroy the infrastructure once you are finished:

```bash
cd aws
terraform destroy --auto-approve
```
