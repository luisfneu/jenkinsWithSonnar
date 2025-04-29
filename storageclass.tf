resource "kubernetes_storage_class" "gp2_immediate" {
  metadata {
    name = "gp2-immediate"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner     = "kubernetes.io/aws-ebs"
  volume_binding_mode     = "Immediate"
  reclaim_policy          = "Delete"
  allow_volume_expansion  = true

  parameters = {
    type = "gp2"
  }
  depends_on = [ helm_release.aws-ebs-csi-driver ]
}