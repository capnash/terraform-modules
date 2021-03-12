resource "aws_instance" "instance" {
    ami = "${var.image}"
    availability_zone = "${var.a_z}"
    placement_group = "${var.group}"
    tenancy = "${var.tenancy}"
    ebs_optimized = "${var.ebs}"
    disable_api_termination = "${var.protected}"
    instance_initiated_shutdown_behavior = "${var.shutdown}"
    instance_type = "${var.size}"
    key_name = "${var.key}"
    get_password_data = "${var.passwd}"
    monitoring = "${var.monitor}"
    vpc_security_group_ids = "${var.sec_groups}"
    subnet_id = "${var.subnet}"
    private_ip = "${var.ip}"
    source_dest_check = "${var.dest_check}"
    user_data = "${var.config}"
    iam_instance_profile = "${var.role}"
    root_block_device {
        volume_type = "${var.volume_type}"
        volume_size = "${var.volume_size}"
        delete_on_termination = "${var.volume_delete}"
        iops = "${var.iops}"
    }
    tags = {
        Name = "${upper(var.caller)}-${var.name}"
        Description = "${var.description}"
        Environment = "${upper(var.caller)}"
        Service = "${var.svc}"
    }

    count = "${local.farm}"
}
