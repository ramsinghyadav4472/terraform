output "aws_instance_public_ip" { // Output for the public IP of the EC2 instance ye ec2 insatce ki public ip show karega terminal me 
  description = "Public IP of the EC2 instance"
  value = aws_instance.myserver.public_ip
}