import  {
    id = "sg-0cff1659c6b230292"
    to = aws_security_group.bia-db
}

import  {
    id = "sg-0f161670b511836f2"
    to = aws_security_group.bia-web
}

import  {
    id = "sg-039edba057ed0d591"
    to = aws_security_group.bia-ec2
}

import  {
    id = "sg-0a8e3276ee1d4b18e"
    to = aws_security_group.bia-alb
}
