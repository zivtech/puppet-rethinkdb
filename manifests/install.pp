class rethinkdb::install inherits rethinkdb {
  include 'apt'
  apt::source { 'rethinkdb':
    comment  => 'The official rethinkdb debian repo.',
    location => 'http://download.rethinkdb.com/apt',
    key      => {
      'id'     => '1614552E5765227AEC39EFCFA7E00EF33A8F2399',
      'source' => 'http://download.rethinkdb.com/apt/pubkey.gpg',
    },
    include => {
      deb => true,
    },
  }

  package { 'rethinkdb':
    name   => $rethinkdb::package_name,
    ensure => $rethinkdb::package_ensure,
  }
}
