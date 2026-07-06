resource "aws_iam_role" "eks_role" {
  name = "shopsphere-eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}
resource "aws_iam_role_policy_attachment" "eks_policy" {


  role = aws_iam_role.eks_role.name


  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"


}

resource "aws_eks_cluster" "main" {


  name = "shopsphere-eks"


  role_arn = aws_iam_role.eks_role.arn


  vpc_config {


    subnet_ids = var.private_subnets


  }


  depends_on = [

    aws_iam_role_policy_attachment.eks_policy

  ]


}
resource "aws_iam_role" "node_role" {


  name = "shopsphere-node-role"


  assume_role_policy = jsonencode({


    Version = "2012-10-17"


    Statement = [{


      Effect = "Allow"


      Action = "sts:AssumeRole"


      Principal = {


        Service = "ec2.amazonaws.com"


      }


    }]


  })


}
resource "aws_iam_role_policy_attachment" "worker" {


  role = aws_iam_role.node_role.name


  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"


}



resource "aws_iam_role_policy_attachment" "cni" {


  role = aws_iam_role.node_role.name


  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"


}



resource "aws_iam_role_policy_attachment" "registry" {


  role = aws_iam_role.node_role.name


  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"


}
resource "aws_eks_node_group" "nodes" {


  cluster_name = aws_eks_cluster.main.name


  node_group_name = "shopsphere-workers"


  node_role_arn = aws_iam_role.node_role.arn


  subnet_ids = var.private_subnets



  scaling_config {


    desired_size = 2


    max_size = 3


    min_size = 1


  }



  instance_types = ["t3.small"]


  depends_on = [


    aws_iam_role_policy_attachment.worker,

    aws_iam_role_policy_attachment.cni,

    aws_iam_role_policy_attachment.registry


  ]


}
