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

## Build package

    PKG_VERSION=$(date '+%Y%m%d%H%M')
    wget https://github.com/elasticsearch/kibana/archive/master.tar.gz
    mkdir -p build/usr/share
    tar xvzf master.tar.gz
    mv kibana-master build/usr/share/kibana3

    cat << 'EOF' > post-install
    #!/bin/sh
    chown -R www-data:www-data /usr/share/kibana3
    EOF

    fpm -s dir -t deb \
      --architecture all \
      -n kibana3 \
      -v ${PKG_VERSION} \
      --prefix / \
      --after-install post-install \
      -C build usr

There's obviously room for improvement, I just wanted to show you a quick and
dirty example how to create a Kibana3 package for development purposes.

## Contributing

* Fork it
* Create a feature branch (`git checkout -b my-new-feature`)
* Run rspec tests (`bundle exec rake spec`)
* Commit your changes (`git commit -am 'Added some feature'`)
* Push to the branch (`git push origin my-new-feature`)
* Create new Pull Request

