require './lib/brakeman/version'
require './gem_common'
gem_priv_key = File.expand_path("~/.ssh/gem-private_key.pem")

Gem::Specification.new do |s|
  s.name = %q{brakeman}
  s.version = Brakeman::Version
  s.authors = ["Justin Collins"]
  s.email = "gem@brakeman.org"
  s.summary = "Security vulnerability scanner for Ruby on Rails."
  s.description = "Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis."
  s.homepage = "http://brakemanscanner.org"
  s.files = ["bin/brakeman", "CHANGES.md", "FEATURES", "README.md"] + Dir["lib/**/*"]
  s.executables = ["brakeman"]
  s.license = "MIT"
  s.cert_chain  = ['brakeman-public_cert.pem']
  s.signing_key = gem_priv_key if File.exist? gem_priv_key and $0 =~ /gem\z/

  if File.exist? 'bundle/load.rb'
    s.files += Dir['bundle/ruby/*/gems/**/*'] + ['bundle/load.rb']
  else
    Brakeman::GemDependencies.dev_dependencies(s) unless ENV['BM_PACKAGE']
    Brakeman::GemDependencies.base_dependencies(s)
    Brakeman::GemDependencies.extended_dependencies(s)
  end
end
