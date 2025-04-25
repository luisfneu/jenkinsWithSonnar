resource "helm_release" "aws-ebs-csi-driver" {
  name             = "aws-ebs-csi-driver"
  namespace        = "kube-system"
  repository       = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart            = "aws-ebs-csi-driver"
  version          = "2.30.0"
  create_namespace = false
}
resource "helm_release" "jenkins" {
  name             = "jenkins"
  namespace        = "jenkins"
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  create_namespace = true
  values = [
    "${file("jenkins-values.yaml")}"
  ]

  set_sensitive {
    name  = "controller.admin.username"
    value = var.jenkins_admin_user
  }

  set_sensitive {
    name  = "controller.admin.password"
    value = var.jenkins_admin_password
  }
  depends_on = [ helm_release.aws-ebs-csi-driver ]
}

