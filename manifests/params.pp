class pound::params {

  $package_ensure = 'present'
  $service_ensure = 'running'
  $service_manage = true
  $user           = 'nobody'
  $group          = 'nobody'

  case $::osfamily { 
    'RedHat': { 
      $package_name = 'Pound' 
      $config_name  = '/etc/pound.cfg'
    }

    default: { 
      fail("${::osfamily} not supported.") 
    }
  }
}
