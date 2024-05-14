resource "aws_eks_cluster" "EKS" {
  name     = "Blue-Rental-Car-EKS"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_service_policy
  ]
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.EKS.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.eks_worker_role.arn
  subnet_ids      = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = ["t3a.medium"]

  ami_type = "AL2_x86_64"

  depends_on = [
    aws_eks_cluster.EKS
  ]
}
