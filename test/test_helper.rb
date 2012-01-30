require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'json'
require 'ostruct'

%w(base candidate committee contribution individual_contribution filing form independent_expenditure president).each do |f|
  require File.join(File.dirname(__FILE__), '../lib/campaign_cash', f)
end

# set your NYT Campaign Finance API key as an environment variable to run the tests
API_KEY = ENV['NYT_CAMPFIN_API_KEY']
CampaignCash::Base.api_key = API_KEY

module TestCampaignCash
end
