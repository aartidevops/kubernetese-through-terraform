resource "kubernetes_config_map" "cart" {
  metadata {
    name      = "cart"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
  }

  data = {
    REDIS_HOST     = "10.0.0.10"
    CATALOGUE_HOST = "catalogue"
    CATALOGUE_PORT = "8080"
  }
}

resource "kubernetes_deployment" "cart" {
  metadata {
    name      = "cart"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
    labels = {
      app = "cart"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "cart"
      }
    }

    template {
      metadata {
        labels = {
          app = "cart"
        }
      }

      spec {
        container {
          name  = "cart"
          image = "public.ecr.aws/w8x4g9h7/roboshop-v3/cart"

          port {
            container_port = 80
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.cart.metadata[0].name
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "cart" {
  metadata {
    name      = "cart"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
  }

  spec {
    selector = {
      app = "cart"
    }

    port {
      port        = 8080
      target_port = 80
    }

    type = "ClusterIP"
  }
}
