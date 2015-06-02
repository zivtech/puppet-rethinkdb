define rethinkdb::instance (
  $custom_server_name = false,
  $conf = false,
  $ensure = 'present'
) {

  validate_hash($conf)
  
  file { "rethinkdb-instance-${name}":
    path    => "${rethinkdb::instance_path}/${name}.conf",
    content => template("${module_name}/instance.conf.erb"),
    ensure  => $ensure,
    notify  => Service[$rethinkdb::service_name],
    require => Class['rethinkdb::install'],
  }
}
