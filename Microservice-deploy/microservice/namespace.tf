resource "kubernetes_namespace" "roboshop" {
  metadata {
    name = "roboshop"
  }
}
