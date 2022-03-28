# NTTDATA - DIGITAL ARCHITECTURE - ENGENIEER
# Create: Marcos Cianci - mlopesci@emeal.nttdata.com
# Date: Sex 11 Mar 2022
# PROJECT AWS FIS - FAULT INJECTION SERVICES



resource "local_file" "network-latency" {

  filename          = "network-latency.json" 
  file_permission   = "0600"

  content           = templatefile("templates/network-latency.tpl", {
    asg             = [var.target_ec2]
    region          = var.aws_region
    alarm           = var.alarm
    role            = var.role_arn
  })

}

resource "local_file" "create-templates" {
  content = join("\n", [
    "#!/bin/bash -ex",
    "OUTPUT='.fis_cli_result'",
    "TEMPLATES=( 'network-latency.json' )",
    "for template in $${TEMPLATES[@]}; do",
    "  aws fis create-experiment-template --cli-input-json file://$${template} --output text --query 'experimentTemplate.id' 2>&1 | tee -a $${OUTPUT}",
    "done",
    ]
  )
  filename        = "fis-create-experiment-templates.sh"
  file_permission = "0600"
}

resource "null_resource" "create-templates" {
  depends_on = [
    local_file.network-latency
  ]
  provisioner "local-exec" {
    when    = create
    command = "bash fis-create-experiment-templates.sh"
  }
}