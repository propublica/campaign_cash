require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'mocha'
require 'json'

require File.dirname(__FILE__) + '/../lib/campaign_cash'
require File.dirname(__FILE__) + '/../lib/campaign_cash/base'
require File.dirname(__FILE__) + '/../lib/campaign_cash/candidate'
require File.dirname(__FILE__) + '/../lib/campaign_cash/committee'
require File.dirname(__FILE__) + '/../lib/campaign_cash/contribution'
require File.dirname(__FILE__) + '/../lib/campaign_cash/filing'
require File.dirname(__FILE__) + '/../lib/campaign_cash/form'

# set your NYT Campaign Finance API key as an environment variable to run the tests
API_KEY = ENV['NYT_CAMPFIN_API_KEY']
CampaignCash::Base.api_key = API_KEY

def api_url_for(path, params = {})
	full_params = params.merge 'api-key' => API_KEY
	CampaignCash::Base.build_request_url(path, full_params).to_s
end

module TestCampaignCash
end
