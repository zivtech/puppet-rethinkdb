# Puppet RethinkDB

Install [rethinkdb]() from the official package repo.  Currently only
support debian based installs, patches welcome.  Allows you to configure
an multiple instances.


## Basic Useage

Install rethink from source, configure the service to start by default,
and configure a default instance called `rethinkdb`.

```` puppet
include rethinkdb
````

## Advanced Useage

You can pass ini file configurations directly through the instance configuration
by hassing a hash to the `conf` parameter.

Below we install rethink *without* setting up an instance and then 

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
  }
}
````
