resource "kubernetes_stateful_set" "rabbitmq" {

    depends_on = [ kubernetes_config_map.rabbitmq ]

    metadata {

        name      = var.name
        namespace = var.namespace

        labels = {

            app = var.name

        }

    }

    spec {

        replicas     = var.replicas
        service_name = "rabbitmq"

        selector {

            match_labels = {

                app = var.name

            }

        }

        template {

            metadata {

                name = var.name

                labels = {

                    app = var.name

                }

            }

            spec {

                service_account_name             = var.name
                node_selector                    = var.node_selector
                termination_grace_period_seconds = 10

                container {

                    name = "rabbitmq"

                    image = var.image

                    port {

                        name           = "amqp"
                        container_port = 5672
                        protocol       = "TCP"

                    }

                    port {

                        name           = "management"
                        container_port = 15672
                        protocol       = "TCP"

                    }

                    liveness_probe {

                        period_seconds        = 30
                        initial_delay_seconds = 10
                        timeout_seconds       = 10

                        exec {

                            command = [ "rabbitmq-diagnostics", "status" ]

                        }

                    }

                    readiness_probe {

                        period_seconds        = 30
                        initial_delay_seconds = 10
                        timeout_seconds       = 10

                        exec {

                            command = [ "rabbitmq-diagnostics", "ping" ]

                        }

                    }

                    env {

                        name = "MY_POD_IP"

                        value_from {

                            field_ref {

                                field_path = "status.podIP"

                            }

                        }

                    }

                    env {

                        name  = "RABBITMQ_USE_LONGNAME"
                        value = "true"

                    }

                    env {

                        name  = "RABBITMQ_ERLANG_COOKIE"
                        value = "changeme"

                    }

                    env {

                        name  = "K8S_SERVICE_NAME"
                        value = var.name

                    }

                    env {

                        name  = "RABBITMQ_NODENAME"
                        value = "rabbit@$(MY_POD_IP)"

                    }

                    env {

                        name  = "RABBITMQ_DEFAULT_USER"
                        value = var.default_username

                    }

                    env {

                        name  = "RABBITMQ_DEFAULT_PASS"
                        value = var.default_password

                    }

                    volume_mount {

                        name       = "config"
                        mount_path = "/etc/rabbitmq"

                    }

                }

                volume {

                    name = "config"

                    config_map {

                        name = var.name

                        items {

                            key  = "rabbitmq.conf"
                            path = "rabbitmq.conf"

                        }

                        items {

                            key  = "enabled_plugins"
                            path = "enabled_plugins"

                        }

                    }

                }

            }

        }

    }

}
