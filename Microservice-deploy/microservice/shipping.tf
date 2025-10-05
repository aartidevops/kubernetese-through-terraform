resource "kubernetes_deployment" "shipping" {
  metadata {
    name      = "shipping"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
    labels = {
      app = "shipping"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "shipping"
      }
    }

    template {
      metadata {
        labels = {
          app = "shipping"
        }
      }

      spec {
        container {
          name  = "shipping"
          image = "your-shipping-image:latest"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "shipping" {
  metadata {
    name      = "shipping-service"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.shipping.metadata[0].labels.app
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
