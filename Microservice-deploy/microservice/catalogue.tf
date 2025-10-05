resource "kubernetes_deployment" "catalogue" {
  metadata {
    name      = "catalogue"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
    labels = {
      app = "catalogue"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "catalogue"
      }
    }

    template {
      metadata {
        labels = {
          app = "catalogue"
        }
      }

      spec {
        container {
          name  = "catalogue"
          image = "your-catalogue-image:latest"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "catalogue" {
  metadata {
    name      = "catalogue-service"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
  }

  spec {
    selector = {
      app = kubernetes_deployment.catalogue.metadata[0].labels.app
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
