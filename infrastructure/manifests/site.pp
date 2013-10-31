Exec {
  path => ["/bin:/usr/bin:/usr/local/bin:/usr/sbin:/sbin"]
}

node default {
  include system
  include miscpackages
  include networking
  include bitclock
}
