$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "campaign_cash/base"
require "campaign_cash/candidate"
require "campaign_cash/committee"
require "campaign_cash/contribution"
require "campaign_cash/filing"
require "campaign_cash/version"
