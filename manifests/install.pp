class rethinkdb::install inherits rethinkdb {

  include 'apt'

  if ($rethinkdb::manage_repo) {
    apt::source { 'rethinkdb':
      comment  => 'The official rethinkdb debian repo.',
      location => 'http://download.rethinkdb.com/apt',
      key      => {
        'id'     => '3B87619DF812A63A8C1005C30742918E5C8DA04A',
        'source' => 'http://download.rethinkdb.com/apt/pubkey.gpg',
      },
      include => {
        deb => true,
      },
    }
  }

  package { 'rethinkdb':
    name   => $rethinkdb::package_name,
    ensure => $rethinkdb::package_ensure,
    require => [
      Class['apt::update'],
      Apt::Source['rethinkdb'],
    ],
  }

}
