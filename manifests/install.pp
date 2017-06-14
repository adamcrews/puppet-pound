# This is a private class, not intended to be used
# independent of the main class.
class pound::install inherits pound {
  assert_private("${name} is a pivate class, not meant to be called directly.")

  package { 'pound':
    ensure => $pound::package_ensure,
    name   => $pound::package_name,
  }
}
