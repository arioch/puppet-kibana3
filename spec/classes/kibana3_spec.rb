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

  describe 'on Debian without parameters' do
    it { should create_class('kibana3') }
    it { should include_class('kibana3::install') }
    it { should include_class('kibana3::config') }

    #it { should contain_package('kibana3').with_ensure('present') }
    it { should contain_file('/usr/share/kibana3').with_ensure('directory') }
  end

  describe 'on Debian with parameter: config_file' do
    let (:params) { { :config_file => '_VALUE_' } }

    it {
      should contain_file('_VALUE_').with(
        'ensure'  => 'present',
        'content' => /elasticsearch:/
      )
    }
  end

  describe 'on Debian with parameter: config_file_mode' do
    let (:params) { { :config_file_mode => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'mode' => '_VALUE_'
      )
    }
  end

  describe 'on Debian with parameter: config_group' do
    let (:params) { { :config_group => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'group' => '_VALUE_'
      )
    }
  end

  describe 'on Debian with parameter: config_user' do
    let (:params) { { :config_user => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'owner' => '_VALUE_'
      )
    }
  end

  describe 'on Debian with parameter: daemon_group' do
    let (:params) { { :daemon_group => '_VALUE_' } }

    it {
      should contain_file('/var/log/apache2/kibana3').with(
        'group' => /_VALUE_/
      )
    }
  end

  describe 'on Debian with parameter: daemon_user' do
    let (:params) { { :daemon_user => '_VALUE_' } }

    it {
      should contain_file('/var/log/apache2/kibana3').with(
        'owner' => /_VALUE_/
      )
    }
  end

  describe 'on Debian with parameter: elasticsearch_host' do
    let (:params) { { :elasticsearch_host => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'ensure'  => 'present',
        'content' => /elasticsearch:.*_VALUE_:/
      )
    }
  end

  describe 'on Debian with parameter: elasticsearch_index' do
    let (:params) { { :elasticsearch_index => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'ensure'  => 'present',
        'content' => /kibana_index:.*_VALUE_/
      )
    }
  end

  describe 'on Debian with parameter: elasticsearch_port' do
    let (:params) { { :elasticsearch_port => '_VALUE_' } }

    it {
      should contain_file('/usr/share/kibana3/config.js').with(
        'ensure'  => 'present',
        'content' => /elasticsearch:.*:_VALUE_/
      )
    }
  end

  #describe 'on Debian with parameter: pkg_ensure' do
  #  let (:params) { { :pkg_ensure => '_VALUE_' } }
  #
  #  it {
  #    should contain_package('kibana3').with(
  #      'ensure' => '_VALUE_'
  #    )
  #  }
  #end

  #describe 'on Debian with parameter: pkg_list' do
  #  let (:params) { { :pkg_list => '_VALUE_' } }
  #
  #  it {
  #    should contain_package('_VALUE_')
  #  }
  #end

  describe 'on Debian with parameter: service_name' do
    let (:params) { { :service_name => '_VALUE_' } }

    it { should create_class('kibana3') }
  end
end

