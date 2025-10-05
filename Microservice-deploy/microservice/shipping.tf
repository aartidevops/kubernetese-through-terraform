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
          image = "public.ecr.aws/w8x4g9h7/roboshop-v3/shipping"

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
    name      = "shipping"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
  }

  spec {
    selector = {
      app = "shipping"
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
