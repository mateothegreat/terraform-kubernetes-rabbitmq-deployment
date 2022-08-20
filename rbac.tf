resource "kubernetes_service_account" "rabbitmq" {

    metadata {

        name      = var.name
        namespace = var.namespace

    }

}

resource "kubernetes_role" "rabbitmq" {

    metadata {

        name      = var.name
        namespace = var.namespace

    }

    rule {

        api_groups = [ "" ]
        resources  = [ "endpoints" ]
        verbs      = [ "get", "list", "watch" ]

    }

    rule {

        api_groups = [ "" ]
        resources  = [ "endpoints" ]
        verbs      = [ "get" ]

    }

}

resource "kubernetes_role_binding" "rabbitmq" {

    metadata {

        name      = var.name
        namespace = var.namespace

    }

    subject {

        kind      = "ServiceAccount"
        name      = var.name
        namespace = var.namespace

    }

    role_ref {

        api_group = "rbac.authorization.k8s.io"
        kind      = "Role"
        name      = var.name

    }

}