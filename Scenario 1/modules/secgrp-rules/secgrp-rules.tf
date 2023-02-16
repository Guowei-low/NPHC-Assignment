resource "aws_security_group_rule" "sg_rule" {
  count                    = length(var.sg_rules)
  type                     = var.sg_rules[count.index].type
  from_port                = var.sg_rules[count.index].from_port
  to_port                  = var.sg_rules[count.index].to_port
  protocol                 = var.sg_rules[count.index].protocol
  description              = var.sg_rules[count.index].description
  cidr_blocks              = var.sg_rules[count.index].cidr_blocks
  prefix_list_ids          = var.sg_rules[count.index].prefix_list_ids
  source_security_group_id = var.sg_rules[count.index].security_groups
  security_group_id        = var.sgrp_id
}
