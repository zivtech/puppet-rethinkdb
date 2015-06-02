# Puppet RethinkDB

Install [rethinkdb](http://rethinkdb.com/) from the official package repo.
Currently only support debian based installs, patches welcome.  Allows
you to configure multiple instances.


## Basic Useage

Install rethink from official package repositories, configure the service
to start by default, and configure a default instance called `rethinkdb`.

```` puppet
include rethinkdb
````

## Advanced Useage

You can pass ini file configurations directly through the instance configuration
by hassing a hash to the `conf` parameter.

Below we install rethink *without* setting up an instance and then define two separate
instances. Please note that we are setting port offset in the configuration so that
the default ports will not collide.

```` puppet
class { 'rethinkdb':
  default_instance => false,
}

rethinkdb::instance { 'foo':
  conf => {
    'port-offset' => 1,
  }
}

rethinkdb::instance { 'bar':
  conf => {
    'port-offset' => 2,
    'cache-size'  => 2048,
  }
}
````
