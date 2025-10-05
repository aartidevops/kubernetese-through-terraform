resource "kubernetes_deployment" "user" {
  metadata {
    name      = "user"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
    labels = {
      app = "user"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "user"
      }
    }

    template {
      metadata {
        labels = {
          app = "user"
        }
      }

      spec {
        container {
          name  = "user"
          image = "your-user-image:latest"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "user" {
  metadata {
    name      = "user-service"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.user.metadata[0].labels.app
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
