# NTTDATA - DIGITAL ARCHITECTURE - ENGENIEER
# Create: Marcos Cianci - mlopesci@emeal.nttdata.com
# Date: Sex 11 Mar 2022
# PROJECT AWS FIS - FAULT INJECTION SERVICES



resource "local_file" "network-latency" {

  filename          = "${path.module}/network-latency.json" 
  file_permission   = "0600"

  content           = templatefile("${path.module}/templates/network-latency.tpl", {
    asg             = [var.target_ec2]
    region          = var.aws_region
    alarm           = var.alarm
    role            = var.role_arn
  })

}