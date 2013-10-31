class bitclock {
  include bitclock::package
  include bitclock::service

  Class["bitclock::package"] -> Class["bitclock::service"]
}
