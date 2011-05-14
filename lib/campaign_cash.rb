# A Ruby wrapper for [The New York Times Campaign Finance API](http://developer.nytimes.com/docs/read/campaign_finance_api).

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "campaign_cash/base"
# [Candidate methods](candidate.html)
require "campaign_cash/candidate"
# [Committee methods](committee.html)
require "campaign_cash/committee"
# [Filing methods](filing.html)
require "campaign_cash/filing"
require "campaign_cash/contribution"
require "campaign_cash/form"
require "campaign_cash/version"
