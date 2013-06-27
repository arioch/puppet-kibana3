# == Class kibana3::install
#
class kibana3::install {
  package { $::kibana3::pkg_list:
    ensure => $::kibana3::pkg_ensure,
  }

  if $::kibana3::pkg_deps {
    package { $::kibana3::pkg_deps:
      ensure => $::kibana3::pkg_ensure,
      before => Package[$::kibana3::pkg_list],
    }
  }
}

