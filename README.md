# Puppet kibana3

## Build status

[![Build Status](https://travis-ci.org/arioch/puppet-kibana3.png?branch=master)](https://travis-ci.org/arioch/puppet-kibana3)

### Install kibana3

    node /box/ {
      include kibana3
    }

### Configure kibana3

    node /box/ {
      class { 'kibana3':
        elasticsearch_host  => '127.0.0.1',
        elasticsearch_index => 'kibana-int',
        elasticsearch_port  => '9200',
      }
    }

## Contributing

* Fork it
* Create a feature branch (`git checkout -b my-new-feature`)
* Run rspec tests (`bundle exec rake spec`)
* Commit your changes (`git commit -am 'Added some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Create new Pull Request

