class pound::params {

  $package_ensure = 'present'
  $service_ensure = 'running'
  $service_manage = true
  $user           = 'nobody'
  $group          = 'nogroup'
  $ciphers        = 'ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS;'

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
