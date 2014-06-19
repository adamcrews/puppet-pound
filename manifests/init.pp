# == Class: pound
#
# Full description of class pound here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { pound:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class pound (
  $package_ensure = 'present',
  $package_name   = $pound::params::package_name,
  $service_ensure = 'running',
  $service_manage = true,
  $config_name    = $pound::params::config_name,
) inherits pound::params {

  anchor { 'pound::begin': }
  -> class { '::pound::install': }
  -> class { '::pound::config': }
  ~> class { '::pound::service': }
  -> anchor { 'pound::end': }

}
