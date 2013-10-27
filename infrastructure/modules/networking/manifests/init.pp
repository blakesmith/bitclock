class networking {
  file { "/etc/network/interfaces":
    owner => "root",
    group => "root",
    mode => 644,
    source => "puppet:///modules/networking/interfaces"
  }

  file { "/etc/wpa_supplicant/wpa_supplicant.conf":
    owner => "root",
    group => "root",
    mode => 644,
    source => "puppet:///modules/networking/wpa_supplicant.conf"
  }

}
