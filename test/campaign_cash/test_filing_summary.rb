require 'test_helper'

class TestCampaignCash::TestFilingSummary < Minitest::Test
	include CampaignCash
	
	context "filing summaries" do
	  setup do
	    @filing_summary = FilingSummary.by_id(751678)
    end
    should "get a filing by form id" do
      assert_kind_of(FilingSummary, @filing_summary)
    end
  end	
end