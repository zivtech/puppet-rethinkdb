class rethinkdb (
  $manage_service = rethinkdb::params::manage_service,
  $service_ensure = rethinkdb::params::service_ensure,
  $package_ensure = rethinkdb::params::package_ensure
) inherits rethinkdb::params {

  validate_bool($manage_service)

  include rethinkdb::install

  if ($manage_service) {
    include rethinkdb::service
  }
}
