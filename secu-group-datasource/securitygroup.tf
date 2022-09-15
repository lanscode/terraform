data "aws_ip_ranges" "us_east_ip_range"{
    regions = ["us-east-1","us-east-2"]
    services = ["ec2"]
}

resource "aws_security_group" "sg_kroia_us_east"{
    name = "sg_koria_us_east"
    ingress{
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = data.aws_ip_ranges.us_east_ip_range.cidr_blocks
    }
    tags={
        createDate = data.aws_ip_ranges.us_east_ip_range.create_date
        syncToken = data.aws_ip_ranges.us_east_ip_range.sync_token
    }
}