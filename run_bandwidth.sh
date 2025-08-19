#!/bin/bash

# Define the path to your vault password file
VAULT_PASSWORD_FILE=/home/test/bandwidth/.vault_pass.txt

# Decrypt the secrets.yml and export variables
export_vars=$(ansible-vault view secrets.yml --vault-password-file "${VAULT_PASSWORD_FILE}" | grep -E '^(db_user|db_password|db_name|fortigate_api_key|telegram_bot_token|telegram_chat_id)' | sed -E 's/^\s*([^>eval export "$export_vars"

# Stop and remove the old containers to prevent conflicts
sudo docker compose down
sudo docker rm -f postgres-db
sudo docker rm -f grafana

# Start the Docker containers
sudo docker compose up -d

# Wait for the PostgreSQL container to fully start up and be ready
echo "Waiting for PostgreSQL to become available..."
sleep 10 # <-- Add a delay here

# Run the Ansible playbook
ansible-playbook -i /home/test/bandwidth/inventory.ini /home/test/bandwidth/bandwidth.yml --vault-password-file "${VAULT_PASSWORD_FILE}"
