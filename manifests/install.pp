# This is a private class, not intended to be used
# independent of the main class.
class pound::install inherits pound {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'pound':
    name   => $package_name, 
    ensure => $package_ensure,
  }

}
