data "eu_ip_range" "eu_west_ip_range"{
    regions = ["eu-west-1","eu-west-2"]
    services = ["EC2"]
}