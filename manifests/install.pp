class rethinkdb::install inherits rethinkdb {

  $user = $::rethinkdb::service_user
  $group = $::rethinkdb::service_group
  $checksum = $::rethinkdb::checksum
  $fetch_url = $::rethinkdb::fetch_url
  $instance_path = $::rethinkdb::instance_path

  user { $user:
    comment    => 'The user used to run rethinkdb.',
    ensure     => 'present',
    home       => '/var/lib/rethinkdb',
    membership => 'minimum',
  }->
  file { '/etc/rethinkdb':
    owner  => $user,
    group  => $group,
    mode   => '0755',
    ensure => 'directory',
  }->
  file { $instance_path:
    owner  => $user,
    group  => $group,
    mode   => '0755',
    ensure => 'directory',
  }

  wget::fetch { "${fetch_url}":
    destination => "/tmp/rethinkdb.tgz",
    # Currently, cache_dir doesn't work with source_hash.
    # https://github.com/voxpupuli/puppet-wget/issues/87
    #cache_dir   => '/var/cache/rethinkdb',
    #unless      => "/usr/bin/test /tmp/rethinkdb",
    redownload  => false,
    source_hash => $checksum,
    timeout     => 0,
    verbose     => false,
  }~>
  exec { "uncompress /tmp/rethinkdb.tgz":
    command => "/bin/tar -xzf /tmp/rethinkdb.tgz",
    cwd     => '/tmp',
    creates => "/tmp/rethinkdb",
  }~>
  file { '/usr/bin/rethinkdb':
    ensure  => present,
    source  => "/tmp/rethinkdb",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }~>
  file { '/usr/lib/tmpfiles.d/rethinkdb.conf':
    ensure  => present,
    content => 'd /run/rethinkdb 0755 rethinkdb rethinkdb -',
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }~>
  file { '/lib/systemd/system/rethinkdb@.service':
    ensure  => present,
    content => template("${module_name}/rethinkdb.service.erb"),
    owner   => $user,
    group   => $group,
    mode    => '0644',
  }
}
