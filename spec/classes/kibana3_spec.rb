require 'spec_helper'

describe 'kibana3', :type => :class do
  let (:facts) { debian_facts }
  let(:pre_condition) { '$concat_basedir = "/tmp"' }
  let (:params) {
    {
      :config_dir => '/usr/share/kibana3',
      :config_file => '/usr/share/kibana3/config.js'
    }
  }

  describe 'without parameters' do
    it { should create_class('kibana3') }
    it { should include_class('kibana3::install') }
    it { should include_class('kibana3::config') }

    it { should contain_package('kibana3').with_ensure('present') }
    it { should contain_file('/usr/share/kibana3').with_ensure('directory') }
  end

  describe 'with parameter: config_dir' do
    let (:params) { { :config_dir => '_VALUE_' } }

    it {
      should contain_file('_VALUE_').with(
        'ensure'  => 'directory'
      )
    }

    it {
      should contain_file('_VALUE_/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /DocumentRoot.*_VALUE_/
      )
    }

    it {
      should contain_file('_VALUE_/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /<Directory.*_VALUE_.*>/
      )
    }

    it {
      should contain_file('_VALUE_/nginx.conf').with(
        'ensure'  => 'present',
        'content' => /root.*_VALUE_.*/
      )
    }
  end

  describe 'with parameter: config_dir_mode' do
    let (:params) {
      {
        :config_dir      => '_CONFIG_DIR_',
        :config_dir_mode => '_VALUE_'
      }
    }

    it {
      should contain_file('_CONFIG_DIR_').with(
        'ensure' => 'directory',
        'mode'   => '_VALUE_'
      )
    }
  end

  describe 'with parameter: config_dir_recurse' do
    let (:params) {
      {
        :config_dir         => '_CONFIG_DIR_',
        :config_dir_recurse => true
      }
    }

    it {
      should contain_file('_CONFIG_DIR_').with(
        'ensure'  => 'directory',
        'recurse' => true
      )
    }
  end

  describe 'with parameter: config_file' do
    let (:params) { { :config_file => '_VALUE_' } }

    it {
      should contain_file('_VALUE_').with(
        'ensure'  => 'present',
        'content' => /elasticsearch:/
      )
    }
  end

  describe 'with parameter: config_file_mode' do
    let (:params) { { :config_file_mode => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'mode' => '_VALUE_'
      )
    }
  end

  describe 'with parameter: config_group' do
    let (:params) { { :config_group => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'group' => '_VALUE_'
      )
    }
  end

  describe 'with parameter: config_dir_recurse' do
    let (:params) {
      {
        :config_dir         => '_CONFIG_DIR_',
        :config_dir_recurse => true
      }
    }

    it {
      should contain_file('_CONFIG_DIR_').with(
        'ensure'  => 'directory',
        'recurse' => true
      )
    }
  end

  describe 'with parameter: config_user' do
    let (:params) { { :config_user => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'owner' => '_VALUE_'
      )
    }
  end

  describe 'with parameter: config_purge' do
    let (:params) {
      {
        :config_dir   => '_CONFIG_DIR_',
        :config_purge => true
      }
    }

    it {
      should contain_file('_CONFIG_DIR_').with(
        'ensure' => 'directory',
        'purge'  => true
      )
    }
  end

  describe 'with parameter: daemon_group' do
    let (:params) {
      {
        :daemon_group => '_VALUE_',
        :log_dir      => '_LOG_DIR_'
      }
    }

    it {
      should contain_file('_LOG_DIR_').with(
        'group' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: daemon_user' do
    let (:params) {
      {
        :daemon_user => '_VALUE_',
        :log_dir     => '_LOG_DIR_'
      }
    }

    it {
      should contain_file('_LOG_DIR_').with(
        'owner' => /_VALUE_/
      )
    }
  end

  describe 'with parameter: elasticsearch_secure=false' do
    let (:params) { { :elasticsearch_secure => false } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'ensure'  => 'present',
        'content' => /elasticsearch:.*http:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /http:\/\/.*/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /ProxyPassMatch.*http:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /ProxyPassReverse.*http:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/nginx.conf').with(
        'ensure'  => 'present',
        'content' => /proxy_pass.*http:/
      )
    }
  end

  describe 'with parameter: elasticsearch_secure=true' do
    let (:params) { { :elasticsearch_secure => true } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'ensure'  => 'present',
        'content' => /elasticsearch:.*https:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /https:\/\/.*/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /ProxyPassMatch.*https:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /ProxyPassReverse.*https:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/nginx.conf').with(
        'ensure'  => 'present',
        'content' => /proxy_pass.*https:/
      )
    }
  end

  describe 'with parameter: elasticsearch_host' do
    let (:params) { { :elasticsearch_host => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'ensure'  => 'present',
        'content' => /elasticsearch:.*_VALUE_:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /http:\/\/.*_VALUE_:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /ProxyPassMatch.*_VALUE_:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /ProxyPassReverse.*_VALUE_:/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/nginx.conf').with(
        'ensure'  => 'present',
        'content' => /proxy_pass.*_VALUE_:/
      )
    }
  end

  describe 'with parameter: elasticsearch_index' do
    let (:params) { { :elasticsearch_index => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'ensure'  => 'present',
        'content' => /kibana_index:.*_VALUE_/
      )
    }
  end

  describe 'with parameter: elasticsearch_port' do
    let (:params) { { :elasticsearch_port => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'ensure'  => 'present',
        'content' => /elasticsearch:.*:_VALUE_/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /:_VALUE_/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /ProxyPassMatch.*:_VALUE_/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /ProxyPassReverse.*:_VALUE_/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/nginx.conf').with(
        'ensure'  => 'present',
        'content' => /proxy_pass.*:_VALUE_/
      )
    }
  end

  describe 'with parameter: log_dir' do
    let (:params) { { :log_dir => '_VALUE_' } }

    it {
      should contain_file('_VALUE_').with(
        'ensure' => 'directory'
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /ErrorLog.*_VALUE_/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'ensure'  => 'present',
        'content' => /CustomLog.*_VALUE_/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/nginx.conf').with(
        'ensure'  => 'present',
        'content' => /access_log.*_VALUE_/
      )
    }
  end

  describe 'with parameter: pkg_deps' do
    let (:params) { { :pkg_deps => '_VALUE_' } }

    it {
      should contain_package('_VALUE_')
    }
  end

  describe 'with parameter: pkg_ensure' do
    let (:params) { { :pkg_ensure => '_VALUE_' } }

    it {
      should contain_package('kibana3').with(
        'ensure' => '_VALUE_'
      )
    }
  end

  describe 'with parameter: pkg_list' do
    let (:params) { { :pkg_list => '_VALUE_' } }

    it {
      should contain_package('_VALUE_')
    }
  end

  describe 'with parameter: server_name' do
    let (:params) { { :server_name => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/apache2.conf').with(
        'content' => /ServerName.*_VALUE_/
      )
    }

    it {
      should contain_file('/usr/share/kibana3/nginx.conf').with(
        'content' => /server_name.*_VALUE_/
      )
    }
  end

  describe 'with parameter: service_name' do
    let (:params) { { :service_name => '_VALUE_' } }

    it { should create_class('kibana3') }
  end
end

