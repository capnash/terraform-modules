# Module: aws_ad_managed

[![Version](https://img.shields.io/badge/version-0.0.1-brightgreen.svg)]()

This module will build the following:

 * AWS Managed Microsoft AD
 * AD Security Group
 

## Inputs

- `tags` - A map of tags to add to all resources
- `ad_domain` - Active Directory Domain FQDN
- `edition` - Active Directory Domain type either Standard or Enterprise
- `enable_sso` - Whether to enable single-sign on for the directory. Requires alias
- `ad_alias` - The alias for the directory (must be unique amongst all aliases in AWS). Required for enable_sso
- `ad_password` - Active Directory Domain Service Account Password
- `subnets` - Subnets to install ad connect into
- `vpc_id` - VPC to install ad connect into
- `ad_description` - A textual description for the directory
- `on_perm_dns_ips` - Map of on-perm DNS server ips
- `domain_type` - Type of managed domain from AWS


## Outputs

- `ad_connection_id`
- `ad_dns_ips`
- `ad_sg_id`
- `ad_access_url`


## Create Trust with On Perm Domain

In this example we make a one way trust, so that users on perm domain can access AWS.

1. Once AWS Managed Microsoft AD is created, log into console and get `DNS address` for that directory
2. Now log into Domain Controller or your DNS Server if not on the same server and open DNS
  a. Create new Conditional Forwarder
  b. Enter the name of the new AWS Managed Microsoft AD as the DNS Domain
  c. Enter the two DNS Address for the AWS Managed Microsoft AD (dont worry about errors inless its a time out error)
  d. Click "store this conditional forwarder in Active Directory, and Replicate it as follows"
  e. Select "All DNS Servers in This domain"
  f. Click Ok
3. Now log into Domain Controller that is on perm and open Open Active Directory Domains and Trusts
  a. Right click to Properties of Domain and open Trust tab
  b. Click New Trusts...
  c. Enter the name of the new AWS Managed Microsoft AD and click next
  d. At this point if you aren't being asked if trust is "External" or "Forest" trust you have done something wrong, could be time, give another 10 mins otherwise go through everything and make sure you can do nslookup of aws domain
  e. Select Forest trust
  f. Select One-way: incoming
  g. Select This domain Only
  h. Enter Trust password, you will need this again when doing the aws side.
  i. Click, next, next, select No do not confirm the incoming trust and click next
  j. Click Finish
4. Log back into AWS console and open page with directory.
  a. Open Network & Security Tab
  b. click Add Trust relationship
  c. Select Forest Trust
  d. Enter the domain of the on perm domain
  e. Enter the trust password from few steps ago
  f. select One-way: Outgoing
  g. Add the DNS servers of on perm DNS servers
  h. Click Add
5. At this point it works or it doesn't.  Thanks to AWS you dont get the real logs of why it doesnt work :(
  First thing in trouble shooting is download a couple of tools, PortqryUI, PortqryUIV2(reason is first version fails to check one port) and test all the ports are open.
  Secondly as AWS doesnt currently provide the logs, submit a case through the support portal and ask, they will tell you whats going on.
6. If it comes up as Verified, then you need to add routing in the domain trust on the on perm domain controller
7. Now log into Domain Controller that is on perm and open Open Active Directory Domains and Trusts
  a. Right click to Properties of Domain and open Name Suffix Routing
  b. Click Refresh
  c. if asked for creds use the username use `<domain name>\admin` - Note that admin is the aws admin user for AD
  d. Enter the Admin password for that domain
  e. If this works you should see a route is enabled
  f. exit and you are now done.
8. To manage new domain, open Users and computers on the on perm domain
9. Right click on the current domain and type in the new aws domain
10. Now you need to add encoretix domain admins to the "AWS Delegated Administrators Role"

Now you are done.