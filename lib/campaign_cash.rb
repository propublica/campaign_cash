$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module CampaignCash
  
end

require "#{File.dirname(__FILE__)}/campaign_cash/base"
require "#{File.dirname(__FILE__)}/campaign_cash/version"
require "#{File.dirname(__FILE__)}/campaign_cash/candidate"
require "#{File.dirname(__FILE__)}/campaign_cash/committee"