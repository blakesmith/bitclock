class system {
  file { "/etc/udev/rules.d/80-spi-devices.rules":
    mode => 644,
    owner => root,
    group => root,
    source => "puppet:///modules/system/spi-devices.rules"
  }
}
