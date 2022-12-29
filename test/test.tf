provider "kubernetes" {

    config_path = "~/.kube/config"

}

module "test" {

    source = "../"

    name         = "rabbitmq"
    namespace    = "default"
    replicas     = 1
    service_type = "LoadBalancer"

    #    service_annotations = {
    #
    #        "cloud.google.com/load-balancer-type" = "Internal"
    #
    #    }
    default_username = "rabbitmq"
    default_password = "agaeq14"

    node_selector = {}

}
