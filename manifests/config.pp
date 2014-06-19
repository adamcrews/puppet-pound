# This is a private class, not intended to be used
# independent of the main class.
class pound::config inherits pound { 
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  concat { $config_name:
    owner => 'root',
    group => 'root',
    mode  => '0444',
  }

  # setup a standard header
  concat::fragment { '00-header':
    target  => $config_name,
    order   => '01',
    content => "#This file is managed by puppet\n",
  }

  concat::fragment { '01-globals':
    target  => $config_name,
    order   => '02',
    content => template("${module_name}/globals.erb"),
  } 
}
