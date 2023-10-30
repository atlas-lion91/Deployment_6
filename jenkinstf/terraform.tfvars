################################### A W S #################################

access_key = ""
secret_key = ""
region = "us-east-1"


################################### I N S T A N C E # 1 #################################

ami = "ami-08c40ec9ead489470"
instance_type_1 = "t2.micro"

                           
instance_1_attach_existing_subnet = "subnet-0759d7060441cb6d0"  
instance_1_existing_sg = ["sg-08ddc2afad5e71fbb"] #for existing security group

instance_1_installs = "installfile1"
key_pair = "dep6_kp"
aws_instance_1_name = "Dep6_jenkins"

################################### I N S T A N C E # 2 #################################

instance_type_2 = "t2.micro"
instance_2_attach_existing_subnet = "subnet-0905d30dd1610af3c"  
instance_2_installs = "installfile2.sh"
aws_instance_2_name = "Dep6_terraform"
