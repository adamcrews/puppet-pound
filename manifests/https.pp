# == Define: pound::https
#
# Configure the pound service
#
# === Parameters
#
# [*cert*]
#   The path to the ssl certificate and key in pem format.  
#   Default: none, but this is required.
#
# [*address*]
#   The ip address to bind to.
#   Default: the $::ipaddress fact.
#
# [*port*]
#   The port to bind to.
#   Default: 443
#
# [*backend*]
#   The host/port to forward requests to.
#   Default: { '127.0.0.1' => '80' }
#
# [*ensure*]
#   Ensure this entry is present or absent.
#   Default: present
#
# [*target*]
#   The config file to update.
#   Default: /etc/pound.cfg
#
# [*custom_template*]
#   Sepcify a custom template vs using the built in one.
#   Default: undefined
#
# [*ciphers*]
#   The ssl/tls ciphers to use.
#   Default: ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS;
#
# [*client_cert*]
#   Client certificate to present
#   Default: undefined
#
# [*rewritelocation*]
#   A url rewrite to use.
#   Default: undefined
#
define pound::https (
  $cert,
  $address          = $::ipaddress,
  $port             = '443',
  $backend          = { '127.0.0.1' => '80' },
  $ensure           = 'present',
  $target           = '/etc/pound.cfg',
  $custom_template  = undef,
  $ciphers          = 'ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS;',
  $client_cert      = undef,
  $rewritelocation  = undef,
) { 
  
  if $custom_template { 
    $content = template($custom_template)
  } else {
    # This template uses $cert, $address, $port, $backend, $ciphers, $client_cert, $rewritelocation
    $content = template("${module_name}/https.erb")
  }
    
  concat::fragment { "https_server-${title}":
    order   => "20-${title}",
    ensure  => $ensure,
    target  => $target,
    content => $content,
  }
}
