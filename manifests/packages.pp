class rethinkdb::packages {

  $dependencies = [
    'protobuf-compiler',
    'python',
    'python-pip',
    'libprotobuf-dev',
    'libprotobuf10',
    'libcurl4-openssl-dev',
    #'libboost-all-dev',
    'libncurses5-dev',
    'libjemalloc-dev',
    'm4'
  ]

  package { $dependencies:
    ensure => 'installed'
  }->

  # https://github.com/rethinkdb/rethinkdb/issues/6725
  package { "rethinkdb":
    ensure  => '2.3.0.post6',
    provider => pip,
  }

}
