# -*- encoding: utf-8 -*-
require File.expand_path("../lib/campaign_cash/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "campaign_cash"
  s.version     = CampaignCash::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Derek Willis']
  s.email       = ['dwillis@gmail.com']
  s.homepage    = "http://rubygems.org/gems/campaign_cash"
  s.description = "A thin client for The New York Times Campaign Finance API"
  s.summary     = "Following the money."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "campaign_cash"
  s.add_runtime_dependency "json"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
