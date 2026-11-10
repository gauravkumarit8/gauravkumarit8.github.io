# DevOps Lab: Terraform + Prometheus + Alertmanager + Grafana

Terraform builds a small AWS network and one EC2 instance. Docker Compose then runs
Prometheus, Alertmanager, node_exporter and Grafana on it.

## 1. Provision (needs AWS credentials and an EC2 key pair)
    cd terraform
    terraform init
    terraform plan  -var key_name=YOUR_KEY -var admin_cidr=YOUR_IP/32
    terraform apply -var key_name=YOUR_KEY -var admin_cidr=YOUR_IP/32

## 2. Start monitoring
    scp -i YOUR_KEY.pem -r ../monitoring ec2-user@<public_ip>:~/
    ssh -i YOUR_KEY.pem ec2-user@<public_ip>
    cd monitoring && docker compose up -d

Open Grafana on :3000 (admin/admin), Prometheus on :9090, Alertmanager on :9093.
Edit `alertmanager.yml` and replace the REPLACE_ME values with a real Slack webhook.

## 3. Test an alert
    docker compose stop node-exporter    # InstanceDown fires after about 1 minute

## 4. Clean up (avoid charges)
    terraform destroy -var key_name=YOUR_KEY -var admin_cidr=YOUR_IP/32

Validate rules locally: `promtool check rules monitoring/alert.rules.yml`
