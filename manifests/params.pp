class pound::params {

  case $::osfamily { 
    'RedHat': { 
      $package_name = 'Pound' 
      $config_name  = '/etc/pound.conf'
    }

    default: { 
      fail("${::osfamily} not supported.") 
    }
  }
}
