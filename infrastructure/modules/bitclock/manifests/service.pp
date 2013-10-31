class bitclock::service {
  user { "bitclock": }
  service {"bitclock":
    ensure => running,
    require => User["bitclock"]
  }
}
