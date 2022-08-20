variable "name" {

    type        = string
    description = "statefulset name"

}

variable "namespace" {

    type        = string
    description = "statefulset namespace"

}

variable "replicas" {

    type        = string
    description = "statefulset replicas"

}

variable "default_usernane" {

    type    = string
    default = "rabbitmq"

}

variable "default_password" {

    type    = string
    default = "rabbitmq"

}

variable "node_selector" {

    type = map(string)

}

variable "image" {

    type    = string
    default = "rabbitmq:3.10.7-management"

}

variable "service_type" {

    type    = string
    default = "NodePort"

}

variable "service_annotations" {

    type    = map(string)
    default = {}

}
