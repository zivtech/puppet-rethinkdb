class rethinkdb (
  $manage_service = $rethinkdb::params::manage_service,
  $service_ensure = $rethinkdb::params::service_ensure,
  $service_name = $rethinkdb::params::service_name,
  $service_user = $rethinkdb::params::service_user,
  $service_group = $rethinkdb::params::service_group,
  $default_instance = $rethinkdb::params::default_instance,
  $default_instance_config = $rethinkdb::params::default_instance_config,
  $instance_path = $rethinkdb::params::instance_path,
  $install_packages = $rethinkdb::params::install_packages,
  $checksum = $::rethink::params::checksum,
  $fetch_url = $::rethink::params::fetch_url,
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
