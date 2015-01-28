#pound

[![Build Status](https://travis-ci.org/adamcrews/puppet-pound.svg)](https://travis-ci.org/adamcrews/puppet-pound)
[![Puppet Forge](http://img.shields.io/puppetforge/v/adamcrews/pound.svg)](https://forge.puppetlabs.com/adamcrews/pound)

####Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and examples](#usage)
3. [Reference - Class, parameter, and fact documentation](#reference)
4. [Limitations](#limitations)
5. [ToDo](#todo)
6. [Contributors](#contributors)

##Overview

This module installs and configures the Pound ssl/tls daemon.

##Usage

`include ::pound` is sufficient to get the server installed.  

Now you need to configure a https vip.

```puppet
pound::https { 'my-virtualnost-name':
  cert    => '/etc/pound/my_ssl_cert.pem',
  ciphers => 'HIGH:!SSLv2:!ADH:!aNULL:!eNULL:!NULL',
}
```

You will need to supply your own ssl cert in pem format.

##Reference

###Classes

####Public Classes

* pound: Main class, includes all other classes

####Private Classes

* pound::install: Handles installing the package.  The package must be in a repo already configured on your system.
* pound::config: Handles the creation of the config file and concatenates the templates together.
* pound::service: Manages the pound service.
* pound::params: Sets the defaults used elsewhere.

####Defined Types

* pound::https: Configure a virtual host to accept ssl/tls connections on.

###Parameters

The following parameters are available in the pound module:

####`package_ensure`

Ensure a package is either present or absent.  Default: present

####`package_name`

The name of the package to install.  Default: Pound

####`service_ensure`

The state of the service.  Default: running

####`service_manage`

Enable or disable management of the service.  Default: true

####`config_name`

The path to the config file.  Default: /etc/pound.cfg

####`user`

The user to drop privelages to.  Default: nobody

####`group`

The group to drop privelages to.  Default: nobody

##Limitations

The cipher selection is limited to what is supported by your underlying openssl implementation.

##ToDo

* Add additional platform support.
* Create some tests.

###Contributors

Individual contributors can be found at: [https://github.com/adamcrews/puppet-pound/graphs/contributors](https://github.com/adamcrews/puppet-pound/graphs/contributors)

