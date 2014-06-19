define pound::https (
  $cert,
  $address          = $::ipaddress,
  $port             = '443',
  $backend          = { '127.0.0.1' => '80' },
  $ensure           = 'present',
  $target           = '/etc/pound.conf',
  $custom_template  = undef,
) { 
  
  if $custom_template { 
    $content = template($custom_template)
  } else {
    # This template uses $cert, $address, $port, $backend
    $contnet = template("${module_name}/https.erb")
  }
    
  concat::fragment { "https_server-${title}":
    order   => "20-${title}",
    ensure  => $ensure,
    target  => $target,
    content => $content,
  }
}
