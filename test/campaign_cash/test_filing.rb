require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCampaignCash::TestFiling < Test::Unit::TestCase
	include CampaignCash
	
	context "a day" do
	  setup do
	    month, day, year = "11", "27", "2010"
		  @filings = Filing.date(year, month, day)
	  end
	  
		should "return a list of objects of the Filing type" do
			assert_kind_of(Filing, @filings.first)
		end
	end
	
	context "today's filings" do
	  setup do
			@filings = Filing.today
	  end
	  
		should "return a list of objects of the Filing type" do
			assert_kind_of(Filing, @filings.first)
		end
	end
end