#!/bin/bash
r_t='s.OPPJZrveIE9cvX3T51ZbUBTW'
tee payload.json <<EOF
{
  "token_policies": "dev-policy",
  "token_ttl": "1h",
  "token_max_ttl": "4h"
}
EOF

curl --header "X-Vault-Token: $r_t"  --request POST --data '{"type": "approle"}'  http://192.168.91.168:8200/v1/sys/auth/approle
curl --header "X-Vault-Token: $r_t"  --request POST  --data @payload.json  http://192.168.91.168:8200/v1/auth/approle/role/jenkins
curl --header "X-Vault-Token: $r_t" --request GET http://127.0.0.1:8200/v1/auth/approle/role/jenkins | jq
role_id=`curl  --header "X-Vault-Token: $r_t" http://192.168.91.168:8200/v1/auth/approle/role/jenkins/role-id | jq .data.role_id` 
secret_id=`curl  --header "X-Vault-Token: $r_t"  --request POST    http://192.168.91.168:8200/v1/auth/approle/role/jenkins/secret-id | jq .data.secret_id`
curl --request POST --data '{"role_id": '$role_id',"secret_id": '$secret_id'}' http://192.168.91.168:8200/v1/auth/approle/login | jq .auth.client_token | cut -d'"' -f2  > /var/lib/jenkins/workspace/jenkins/token
