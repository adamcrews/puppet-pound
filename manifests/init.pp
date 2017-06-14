# pound
#
# A light weight ssl/tls server.
#
# === Author(s)
# Adam Crews <adam.crews@gmail.com>
#
# === Copyright
# Copyright 2017 Adam Crews, unless otherwise noted.
#
# @param package_ensure Ensure the package is either present or absent. Default: present
# @param package_name The name of the package to install. Default: Pound
# @param service_ensure Ensure the service is running or stopped.  Default: running
# @param service_manage Manage the state of the service or not.  Default: true
# @param config_name The path to the config file.  Default: /etc/pound.cfg
# @param user The userid the service runs as. Default: nobody
# @param group The group the service runs as. Default: nobody
#
# @example Declaring the class
#   include pound
#
#   file { '/etc/pound/my_ssl_cert.pem':
#     ensure => file,
#     owner  => root,
#     group  => root,
#     mode   => '0400',
#     source => 'puppet:///secrets/my_ssl_cert.pem',
#   }
#
#   pound::https { 'my-virtualhost-name':
#     cert    => '/etc/pound/my_ssl_cert.pem',
#     ciphers => 'HIGH:!SSLv2:!ADH:!aNULL:!eNULL:!NULL',
#   }
#
class pound (
  Enum['present', 'absent'] $package_ensure,
  String $package_name,
  Enum['running', 'stopped'] $service_ensure,
  Boolean $service_manage,
  Stdlib::Absolutepath $config_file,
  String $user,
  String $group,
  Optional[String] $alive = undef,
  Optional[String] $rootjail = undef,
  Optional[String] $pound_loglevel = undef,
  Optional[String] $pound_logfacility = undef,
  Optional[String] $threads = undef,
  Optional[String] $ignorecase = undef,
  Optional[String] $dynscale = undef,
  Optional[String] $client = undef,
  Optional[String] $timeout = undef,
  Optional[String] $connto = undef,
  Optional[String] $grace = undef,
  Optional[String] $control = undef
) {

  contain ::pound::install
  contain ::pound::config
  contain ::pound::service

  Class['::pound::install']
  -> Class['::pound::config']
  ~> Class['::pound::service']
}
