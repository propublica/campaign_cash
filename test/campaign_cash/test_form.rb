require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCampaignCash::TestForm < Test::Unit::TestCase
	include CampaignCash
		
	context "today's filings" do
	  setup do
			@filings = Filing.today
	  end
	  
		should "return a list of objects of the Filing type" do
			assert_kind_of(Filing, @filings.first)
		end
	end
end