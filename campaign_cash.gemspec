# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "campaign_cash/version"

Gem::Specification.new do |s|
  s.name        = "campaign_cash"
  s.version     = CampaignCash::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Derek Willis']
  s.email       = ['dwillis@nytimes.com']
  s.homepage    = "http://rubygems.org/gems/campaign_cash"
  s.description = "A client for The New York Times Campaign Finance API"
  s.summary     = "Following the money."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "campaign_cash"
  s.add_runtime_dependency "json"
  
  s.add_development_dependency "rake", "0.8.7"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "shoulda"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
