class miscpackages {
  package { ["haskell-platform", "git", "sudo", "tmux"]:
    ensure => present
  }
}
