# Athena

## In Terraform

- Create Athena database - Can choose encrypt or not
- Create Athena workgroup to create folders in the athena database to store query results of each services log - Can choose encrypt or not
- Write Athena named query for athena workgroup
<https://docs.aws.amazon.com/athena/latest/ug/querying-AWS-service-logs.html>

## In AWS Console

To excute query create by `resource "aws_athena_named_query" "athena_named_query"` we need to do these steps below:

- Step 1: On Athena service at Workgroup tab, we switch to workgroup which the query is created
- Step 2: All query created will available in Saved queries tab, click to the query want to run
- Step 3: After that, query will appear in Query editor tab. Click Run query

## In AWS CLI(If cannot do in AWS Console)

- When we created athena_named_query in Saved Queries, excute commands below:

```
aws athena list-named-queries --work-group <workgroup-name> --profile <profile-name>
aws athena get-named-query --named-query-id <named-query-id> --profile <profile-name> --query NamedQuery.QueryString --output text
```

- Copy and paste result of **aws athena get-named-query** cli when excute this:

```
read -d '' querystring << EOF
<get-named-query result>  #Remember fix bash syntax if have
EOF
```

- Check and start query:

```
echo $querystring
aws athena start-query-execution --region <region> --query-string "$querystring" --work-group <workgroup-name> --profile <profile-name>                                              
```

- Result

```
aws athena get-query-execution --query-execution-id <query-execution-id> --profile <profile-name>                                                    
aws athena get-query-results --query-execution-id <query-execution-id> --profile <profile-name>  
```

Ref: <https://frankcontrepois.com/post/20210211-tech-athenafrombash/>
