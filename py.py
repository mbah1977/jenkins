#!/bin/python
import os
import json
r_t='s.OPPJZrveIE9cvX3T51ZbUBTW'
r=os.popen('curl --header "X-Vault-Token: s.OPPJZrveIE9cvX3T51ZbUBTW" --request GET http://127.0.0.1:8200/v1/auth/approle/role/jenkins')
r=r.read()
r=json.loads(r)
print(r['data'])

