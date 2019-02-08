class rethinkdb::install inherits rethinkdb {

  $user = $::rethinkdb::service_user
  $group = $::rethinkdb::service_group
  $checksum = $::rethinkdb::checksum
  $fetch_url = $::rethinkdb::fetch_url

  user { $user:
    comment    => 'The user used to run rethinkdb.',
    ensure     => 'present',
    home       => '/var/lib/rethinkdb',
    membership => 'minimum',
  }->
  file { '/var/lib/rethinkdb':
    owner  => $user,
    group  => $group,
    mode   => '0755',
    ensure => 'directory',
  }->
  wget::fetch { "${fetch_url}":
    destination => "/tmp/rethinkdb.tgz",
    # Currently, cache_dir doesn't work with source_hash.
    # https://github.com/voxpupuli/puppet-wget/issues/87
    #cache_dir   => '/var/cache/rethinkdb',
    unless      => "/usr/bin/test /usr/bin/rethinkdb",
    source_hash => $checksum,
    timeout     => 0,
    verbose     => false,
  }->
  exec { "uncompress ${fetch_binary_url}":
    command => "/bin/tar xzf ${fetch_binary_url}",
    cwd     => '/tmp',
    creates => "/tmp/rethinkdb",
  }->
  file { '/usr/bin/rethinkdb':
    ensure  => present,
    source  => "/tmp/rethinkdb",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }->
  file { '/usr/lib/tmpfiles.d/rethinkdb.conf':
    ensure  => present,
    content => 'd /run/rethinkdb 0755 rethinkdb rethinkdb -',
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }->
  file { '/usr/lib/systemd/system/rethinkdb@.service':
    ensure  => present,
    content => "${module_name}/rethink.service.erb",
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }
}
