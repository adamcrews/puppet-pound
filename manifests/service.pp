# This is a private class, not intended to be used
# independent of the main class.
class pound::service inherits pound {
  assert_private("${name} is a pivate class, not meant to be called directly.")

  $_enable = $pound::service_ensure ? {
    'running' => true,
    default   => false,
  }

  if $pound::service_manage == true {
    service { 'pound':
      ensure     => $pound::service_ensure,
      enable     => $_enable,
      hasrestart => true,
      hasstatus  => true,
    }
  }
}
