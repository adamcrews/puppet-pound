# This is a private class, not intended to be used
# independent of the main class.
class pound::service inherits pound {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $service_manage {

    service { 'pound':
      ensure => $package_ensure,
      enable => $service_ensure ? {
        'running' => true,
        'stopped' => false,
        default   => $service_ensure,
      },
      hasrestart => true,
      hasstatus  => true,
    }
  }
}
