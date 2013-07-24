# == Class kibana3::config
#
class kibana3::config {
  File {
    require => Class['::kibana3::install'],
    notify  => Service[$::kibana3::service_name],
    owner   => $::kibana3::config_user,
    group   => $::kibana3::config_group,
    mode    => $::kibana3::config_file_mode,
  }

  file {
    $::kibana3::config_dir:
      ensure  => directory,
      mode    => $::kibana3::config_dir_mode,
      purge   => $::kibana3::config_purge,
      recurse => $::kibana3::config_dir_recurse;

    $::kibana3::config_file:
      ensure  => present,
      content => template('kibana3/config.js.erb');

    "${::kibana3::config_dir}/apache2.conf":
      ensure  => present,
      content => template('kibana3/apache2.conf.erb');

    "${::kibana3::config_dir}/nginx.conf":
      ensure  => present,
      content => template('kibana3/nginx.conf.erb');
  }

  if $::kibana3::log_dir {
    file { $::kibana3::log_dir:
      ensure => directory,
      owner  => $::kibana3::daemon_user,
      group  => $::kibana3::daemon_group;
    }
  }
}

