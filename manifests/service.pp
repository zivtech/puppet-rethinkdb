class rethinkdb::service inherits rethinkdb::install {

  service { $rethinkdb::service_name:
    ensure  => $rethinkdb::service_ensure,
    require => File['/lib/systemd/system/rethinkdb@.service'],
  }
}
