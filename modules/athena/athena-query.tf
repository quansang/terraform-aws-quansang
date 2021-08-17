data "template_file" "athena_named_query" {
  for_each = {
    for key, value in var.athena_named_query : key => value
    if value.enable == true #Using variable: enable = true(false) when have different between DEV/STG/PROD environment
  }

  template = file("${each.value.query_template}.sql")
  vars     = each.value.query_vars
}

resource "aws_athena_named_query" "athena_named_query" {
  for_each = {
    for key, value in var.athena_named_query : key => value
    if value.enable == true #Using variable: enable = true(false) when have different between DEV/STG/PROD environment
  }

  name      = each.key
  workgroup = each.value.query_workgroup
  database  = aws_athena_database.athena_database.name
  query     = data.template_file.athena_named_query[each.key].rendered

  depends_on = [aws_athena_workgroup.athena_workgroup]
}
