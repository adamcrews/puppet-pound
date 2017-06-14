# This is a private class, not intended to be used
# independent of the main class.
class pound::config inherits pound {

  assert_private("${name} is a pivate class, not meant to be called directly.")

  # SSL certs will go in this directory
  file { '/etc/pound':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0500',
    purge   => true,
    recurse => true,
    backup  => undef,
  }

  concat { $pound::config_file:
    owner => 'root',
    group => 'root',
    mode  => '0444',
  }

  # setup a standard header
  concat::fragment { '00-header':
    target  => $pound::config_file,
    order   => '01',
    content => "#This file is managed by puppet\n",
  }

  concat::fragment { '01-globals':
    target  => $pound::config_file,
    order   => '02',
    content => epp("${module_name}/globals.epp"),
  }
}
