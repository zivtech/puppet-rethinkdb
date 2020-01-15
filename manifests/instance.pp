define rethinkdb::instance (
  $custom_server_name = false,
  $conf = {},
  $ensure = 'present'
) {

  validate_hash($conf)
  $user = $::rethinkdb::service_user
  $group = $::rethinkdb::service_group
  $path = $conf[directory]

  file { "rethinkdb-instance-${name}":
    path    => "${rethinkdb::instance_path}/${name}.conf",
    content => template("${module_name}/instance.conf.erb"),
    ensure  => $ensure,
    notify  => Service[$rethinkdb::service_name],
    require => Class['rethinkdb::install'],
  }

  exec {"/usr/bin/rethinkdb create -d ${path}; /bin/chown ${user}:${group} -R ${path}":
    creates => $path,
  }
}
