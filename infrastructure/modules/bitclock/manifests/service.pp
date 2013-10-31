class bitclock::service {
  user { "bitclock": }
  service {"bitclock":
    ensure => running,
    enable => true,
    require => User["bitclock"]
  }
}
