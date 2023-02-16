output "subnets_id" {
  value       = "${aws_subnet.subnets.*.id}"  
  description = "List of the web subnet's id"
}
output "rtbl_ids" {
  value       = "${aws_route_table.rtbl.*.id}"
  description = "List of the Route table's id"
}
