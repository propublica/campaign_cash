require 'test_helper'

class TestCampaignCash::TestIndependentExpenditure < Test::Unit::TestCase
	include CampaignCash
		
	context "latest independent expenditures" do
	  setup do
			@independent_expenditures = IndependentExpenditure.latest
	  end
	  
		should "return a list of objects of the IndependentExpenditure type" do
			assert_kind_of(IndependentExpenditure, @independent_expenditures.first)
		end
	end
	
	context "independent expenditures by date" do
	  setup do
	    @independent_expenditures = IndependentExpenditure.date("12/13/2011")
	  end
	  
	  should "return at least one independent expenditure against Barack Obama" do
	    assert_equal("P80003338", @independent_expenditures.first.fec_candidate_id)
	  end
	end
	
	context "a committee's independent expenditures in a cycle" do
	  setup do
	    @independent_expenditures = IndependentExpenditure.committee("C00490045", 2012)
	  end
	  
	  should "return an array of IEs in the presidential race" do
	    assert_equal("President", @independent_expenditures.first.office)
	  end
	end
	
end