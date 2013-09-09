# == Class kibana3
#
# $config_dir::            Location of the main configuration directory.
#                          Default: operating system specific.
#
# $config_dir_mode::       Posix file mode for configuration directories.
#                          Default: 0755.
#
# $config_dir_recurse::    Apply the same posix permissions as $config_dir to any
#                          directory contained in $config_dir.
#                          Default: false.
#
# $config_file::           Location of the main configuration file.
#                          Default: operating system specific.
#
# $config_file_mode::      Posix file mode for configuration files.
#                          Default: 0644.
#
# $config_group::          Posix group for configuration files.
#                          Default: operating system specific.
#
# $config_purge::          Whether or not to purge non-puppet managed files
#                          contained in $config_dir.
#                          Default: operating system specific.
#
# $config_user::           Posix user for configuration files.
#                          Default: operating system specific.
#
# $daemon_group::          Unprivileged group to run daemon.
#                          Default: operating system specific.
#
# $daemon_user::           Unprivileged user to run daemon.
#                          Default: operating system specific.
#
# $elasticsearch_secure::   Wether to use http or https protocol.
#                           Default: false (http).
#
# $elasticsearch_host::    Specify which host to connect to.
#                          Default: 127.0.0.1.
#
# $elasticsearch_index::   The default ES index to use for storing Kibana
#                          specific objects such as stored dashboards.
#                          Default: 127.0.0.1.
#
# $elasticsearch_port::    Specify which port to connect to.
#                          Default: 9200.
#
# $log_dir::               Specify directory containing log files.
#                          Default: operating system specific.
#
# $manage_repo::           Add a custom package repository.
#                          Default: false.
#
# $pkg_deps::              Any dependencies that need to be resolved before
#                          installing the main package.
#                          Default: operating system specific.
#
# $pkg_ensure::            Ensure state for packages.
#                          Default: present.
#
# $pkg_list::              An array containing the main package and possibly
#                          a number of dependencies.
#                          Default: operating system specific.
#
# $server_name::           Specify the name of the virtual host.
#                          Default: kibana3.$fqdn
#
# $service_name::          Specify the name of the init script.
#                          Default: operating system specific.
#
class kibana3 (
  $config_dir           = $::kibana3::params::config_dir,
  $config_dir_mode      = $::kibana3::params::config_dir_mode,
  $config_dir_recurse   = $::kibana3::params::config_dir_recurse,
  $config_file          = $::kibana3::params::config_file,
  $config_file_mode     = $::kibana3::params::config_file_mode,
  $config_group         = $::kibana3::params::config_group,
  $config_purge         = $::kibana3::params::config_purge,
  $config_user          = $::kibana3::params::config_user,
  $daemon_group         = $::kibana3::params::daemon_group,
  $daemon_user          = $::kibana3::params::daemon_user,
  $elasticsearch_secure = $::kibana3::params::elasticsearch_secure,
  $elasticsearch_host   = $::kibana3::params::elasticsearch_host,
  $elasticsearch_index  = $::kibana3::params::elasticsearch_index,
  $elasticsearch_port   = $::kibana3::params::elasticsearch_port,
  $log_dir              = $::kibana3::params::log_dir,
  $log_dir_apache       = $::kibana3::params::log_dir_apache,
  $log_dir_nginx        = $::kibana3::params::log_dir_nginx,
  $manage_repo          = $::kibana3::params::manage_repo,
  $pkg_deps             = $::kibana3::params::pkg_deps,
  $pkg_ensure           = $::kibana3::params::pkg_ensure,
  $pkg_list             = $::kibana3::params::pkg_list,
  $server_name          = $::kibana3::params::server_name,
  $service_name         = $::kibana3::params::service_name,
) inherits kibana3::params {
  validate_bool($elasticsearch_secure)
  if ($elasticsearch_secure == true){
    $elasticsearch_protocol = 'https'
  } else {
    $elasticsearch_protocol = 'http'
  }
  class { 'kibana3::install': } ->
  class { 'kibana3::config': } ->
  Class [ 'kibana3' ]
}

