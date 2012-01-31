require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'json'
require 'ostruct'

%w(base candidate committee contribution individual_contribution filing filing_summary form independent_expenditure president).each do |f|
  require File.join(File.dirname(__FILE__), '../lib/campaign_cash', f)
end

require 'nyt_api_key'

# Create a file called nyt_api_key.rb in test/campaign_cash with your API key:
# API_KEY = "your_api_key"
CampaignCash::Base.api_key = API_KEY

module TestCampaignCash
end
