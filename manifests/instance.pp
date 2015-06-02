define rethinkdb::instance (
  $custom_server_name = false,
  $custom_conf = false,
  $ensure = 'present'
) {

  if ($custom_conf) {
    validate_hash($custom_conf)
    $conf = $custom_conf
  }
  else {
    $conf = {
      "server-name" => $name,
    }
  }
  
  file { "rethinkdb-instance-${name}":
    path    => "${rethinkdb::instance_path}/${name}.conf",
    content => template("${module_name}/instance.conf.erb"),
    ensure  => $ensure,
    notify  => Service[$rethinkdb::service_name],
    require => Class['rethinkdb::install'],
  }
}
