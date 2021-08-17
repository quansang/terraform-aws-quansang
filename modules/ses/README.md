# Create My SMTP Crediential

## Automatically by output Terraform

<https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key>

- Using `aws_iam_access_key` resource to convert secret key to ses smtp passsword
- Excuting `terraform output all_smtp_password_v4` to show value in terminal

## Manually by excuting Python - when account running Terraform don't have any permissions with IAM User

- Step 1: Create IAM User
- Step 2: Manual create Access Key/Secret Key
- Step 3: Convert a Secret Access Key for an IAM user to an SMTP password

```Python Code: convert-access-key-iam-to-smtp.py```

```bash
chmod +x convert-access-key-iam-to-smtp.py
./convert-access-key-iam-to-smtp.py --secret <Secret Key> --region ap-northeast-1
```

- [Obtaining your Amazon SES SMTP credentials](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/smtp-credentials.html#smtp-credentials-convert)
