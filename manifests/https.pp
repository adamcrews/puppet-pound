# Define: pound::https
#
# Configure the pound service
#
# @param cert The path to the ssl certificate and key in pem format. Default: none, but this is required.
# @param address The ip address to bind to. Default: $facts['ipaddress']
# @param port The port to bind to. Default: 443
# @param backend The host/port to forward requests to. Default: { '127.0.0.1' => '80' }
# @param target The config file to update. Default: /etc/pound.cfg
# @param ciphers The ssl/tls ciphers to use. Default: ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS;
# @param client_cert Client certificate to present. Default: undefined
# @param custom_template Sepcify a custom template vs using the built in one. Default: undefined
# @param rewritelocation A url rewrite to use. Default: undefined
#
define pound::https (
  Stdlib::Absolutepath $cert,
  String $address = $facts['ipaddress'],
  Integer $port = 443,
  Hash[String, Integer, 1] $backend = { '127.0.0.1' => 80 },
  Stdlib::Absolutepath $target = '/etc/pound.cfg',
  String $ciphers = 'ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS;',
  Optional[Stdlib::Absolutepath] $client_cert = undef,
  Optional[String] $custom_template = undef,
  Optional[String] $rewritelocation = undef,
) {

  if $custom_template {
    $content = template($custom_template)
  } else {
    $arg_hash = {
      cert            => $cert,
      address         => $address,
      port            => $port,
      backend         => $backend,
      ciphers         => $ciphers,
      client_cert     => $client_cert,
      rewritelocation => $rewritelocation,
    }
    $content = epp("${module_name}/https.epp", $arg_hash)
  }

  concat::fragment { "https_server-${title}":
    order   => "20-${title}",
    target  => $target,
    content => $content,
  }
}
