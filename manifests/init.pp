# == Class: pound
#
# A light weight ssl/tls server.
#
# === Parameters
#
# [*package_ensure*]
#   Ensure the package is either present or absent. Default: present
#
# [*package_name*]
#   The name of the package to install. Default: Pound
#
# [*service_ensure*]
#   Ensure the service is running or stopped.  Default: running
#
# [*service_manage*]
#   Manage the state of the service or not.  Default: true
#
# [*config_name*]
#   The path to the config file.  Default: /etc/pound.cfg
#
# [*user*]
#   The userid the service runs as. Default: nobody
#
# [*group*]
#   The group the service runs as. Default: nobody
#
# === Examples
#
# include pound
#
# file { '/etc/pound/my_ssl_cert.pem':
#   ensure => file,
#   owner  => root,
#   group  => root,
#   mode   => '0400',
#   source => 'puppet:///secrets/my_ssl_cert.pem',
# }
#
# pound::https { 'my-virtualhost-name':
#   cert    => '/etc/pound/my_ssl_cert.pem',
#   ciphers => 'HIGH:!SSLv2:!ADH:!aNULL:!eNULL:!NULL',
# }
#
# === Authors
#
# Adam Crews <adam.crews@gmail.com>
#
# === Copyright
#
# Copyright 2014 Adam Crews, unless otherwise noted.
#
class pound (
  $package_ensure = $pound::params::package_ensure,
  $package_name   = $pound::params::package_name,
  $service_ensure = $pound::params::service_ensure,
  $service_manage = $pound::params::service_manage,
  $config_name    = $pound::params::config_name,
  $user           = $pound::params::user,
  $group          = $pound::params::group,
) inherits pound::params {

  anchor { 'pound::begin': }
  -> class { '::pound::install': }
  -> class { '::pound::config': }
  ~> class { '::pound::service': }
  -> anchor { 'pound::end': }

}
