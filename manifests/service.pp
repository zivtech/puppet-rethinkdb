class rethinkdb::service inherits rethinkdb::install {

  service { 'rethinkdb':
    ensure => rethinkdb::service_ensure,
  }
}
