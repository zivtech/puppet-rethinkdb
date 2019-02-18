class rethinkdb::params {
  $manage_service = true
  $service_ensure = 'running'
  $service_name = 'rethinkdb@rethinkdb.service'
  $service_user = 'rethinkdb'
  $service_group = 'rethinkdb'
  $default_instance = true
  $instance_path = '/etc/rethinkdb/instances.d'
  $checksum = '2c3ca9deddd2f1867ad472dbba1c7986'
  $fetch_url = null
  $default_instance_config = {}
}
