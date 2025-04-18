resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"

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