class rethinkdb (
  $manage_service = $rethinkdb::params::manage_service,
  $service_ensure = $rethinkdb::params::service_ensure,
  $package_ensure = $rethinkdb::params::package_ensure,
  $package_name = $rethinkdb::params::package_name,
  $service_name = $rethinkdb::params::service_name,
  $default_instance = $rethinkdb::params::default_instance,
  $default_instance_config = $rethinkdb::params::default_instance_config,
  $instance_path = $rethinkdb::params::instance_path,
  $manage_repo = $rethinkdb::params::manage_repo
) inherits rethinkdb::params {

  validate_bool($manage_service)

  include rethinkdb::install

  if ($manage_service) {
    include rethinkdb::service
  }
  if ($default_instance) {
    rethinkdb::instance { 'rethinkdb':
      conf => $default_instance_config,
    }
  }
}
