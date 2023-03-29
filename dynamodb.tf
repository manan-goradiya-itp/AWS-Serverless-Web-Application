module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name     = "Manan-goradita-wildrydes"
  hash_key = "RideId"
  attributes = [
    {
      name = "RideId"
      type = "S"
    }
  ]


}

output "dynamodb_arn" {
  value = module.dynamodb_table.dynamodb_table_arn
}