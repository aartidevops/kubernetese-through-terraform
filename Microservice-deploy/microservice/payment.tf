resource "kubernetes_deployment" "payment" {
  metadata {
    name      = "payment"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
    labels = {
      app = "payment"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "payment"
      }
    }

    template {
      metadata {
        labels = {
          app = "payment"
        }
      }

      spec {
        container {
          name  = "payment"
          image = "public.ecr.aws/w8x4g9h7/roboshop-v3/payment"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "payment" {
  metadata {
    name      = "payment"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
  }

  spec {
    selector = {
      app = "payment"
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
