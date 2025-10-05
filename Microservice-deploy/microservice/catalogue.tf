resource "kubernetes_config_map" "catalogue" {
  metadata {
    name      = "catalogue"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
  }

  data = {
    REDIS_HOST = "10.0.0.10"
  }
}

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
          image = "public.ecr.aws/w8x4g9h7/roboshop-v3/catalogue"

          port {
            container_port = 8080
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.catalogue.metadata[0].name
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "catalogue" {
  metadata {
    name      = "catalogue"
    namespace = kubernetes_namespace.roboshop.metadata[0].name
  }

  spec {
    selector = {
      app = "catalogue"
    }

    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}
