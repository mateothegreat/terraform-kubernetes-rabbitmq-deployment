resource "kubernetes_config_map" "rabbitmq" {

    metadata {

        name      = var.name
        namespace = var.namespace

    }

    data = {

        #        "enabled_plugins" = "[rabbitmq_management,rabbitmq_peer_discovery_k8s]."
        "enabled_plugins" = "[rabbitmq_management]."

        "rabbitmq.conf" = <<EOF
#            default_vhost = /
            default_user = ${ var.default_username }
            default_pass = ${ var.default_password }

            # default_permissions.configure = .*
            # default_permissions.read = .*
            # default_permissions.write = .*
            ## Cluster formation. See https://www.rabbitmq.com/cluster-formation.html to learn more.
#            cluster_formation.peer_discovery_backend  = rabbit_peer_discovery_k8s
#            cluster_formation.k8s.host = kubernetes.default.svc.cluster.local
            ## Should RabbitMQ node name be computed from the pod's hostname or IP address?
            ## IP addresses are not stable, so using [stable] hostnames is recommended when possible.
            ## Set to "hostname" to use pod hostnames.
            ## When this value is changed, so should the variable used to set the RABBITMQ_NODENAME
            ## environment variable.
            log.file.level = debug
            log.console = true
            log.console.level = debug
            cluster_formation.k8s.address_type = hostname
            ## How often should node cleanup checks run?
            cluster_formation.node_cleanup.interval = 30
            ## Set to false if automatic removal of unknown/absent nodes
            ## is desired. This can be dangerous, see
            ##  * https://www.rabbitmq.com/cluster-formation.html#node-health-checks-and-cleanup
            ##  * https://groups.google.com/forum/#!msg/rabbitmq-users/wuOfzEywHXo/k8z_HWIkBgAJ
#            cluster_formation.node_cleanup.only_log_warning = true
#            cluster_partition_handling = autoheal
            ## See https://www.rabbitmq.com/ha.html#master-migration-data-locality
            queue_master_locator=min-masters
            ## This is just an example.
            ## This enables remote access for the default user with well known credentials.
            ## Consider deleting the default user and creating a separate user with a set of generated
            ## credentials instead.
            ## Learn more at https://www.rabbitmq.com/access-control.html#loopback-users
            loopback_users.guest = false
        EOF

    }

}
