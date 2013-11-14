class networking {
  file { "/etc/network/interfaces":
    owner => "root",
    group => "root",
    mode => 644,
    source => "puppet:///modules/networking/interfaces"
  }
}
