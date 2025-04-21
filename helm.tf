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
}