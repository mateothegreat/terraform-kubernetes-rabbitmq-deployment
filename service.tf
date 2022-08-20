resource "kubernetes_service" "rabbitmq" {

    metadata {

        name        = var.name
        namespace   = var.namespace
        annotations = var.service_annotations

    }

    spec {

        type = var.service_type

        selector = {

            app = var.name

        }

        port {

            name        = "amqp"
            port        = 5672
            target_port = 5672
            protocol    = "TCP"

        }

        port {

            name        = "management"
            port        = 15672
            target_port = 15672
            protocol    = "TCP"

        }

    }

}
