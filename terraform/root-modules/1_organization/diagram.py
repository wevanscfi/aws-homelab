from diagrams import Cluster, Diagram
from diagrams.aws.management import OrganizationsAccount, OrganizationsOrganizationalUnit
from diagrams.aws.security import IAM
import json
import os
import sys
from pprint import pprint

data = json.load(sys.stdin)

org_units = []

for x in data['resources']:
    if x['type'] == 'aws_organizations_organizational_unit':
      org_units.append(x)

with Diagram("Account Structure"):
  for unit in org_units:
    name = unit["instances"][0]["attributes"]["name"]
    accounts = unit["instances"][0]["attributes"]["accounts"]
    with Cluster(name):
        unit = OrganizationsOrganizationalUnit(name)
        for account in accounts:
            unit - OrganizationsAccount(account["name"]) - IAM("IACAccountAdmin")

