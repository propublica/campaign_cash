require 'test_helper'

class TestCampaignCash::TestFiling < Minitest::Test
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
	  
		should "return a list of objects of the Filing type or an empty list" do
		  if @filings.size > 0
			  assert_kind_of(Filing, @filings.first)
			else
			  assert_equal([], @filings)
			end
		end
	end
	
	context "recent statements of organization" do
	  setup do
	    @filings = Filing.by_type(2012, "F1")
	  end
	  
	  should "return a list of the 20 most recent Filings that are statements of organization" do
	    assert_equal @filings.size, 20
	    assert_equal @filings.first.report_title, "STATEMENT OF ORGANIZATION"
	  end
	end	
end