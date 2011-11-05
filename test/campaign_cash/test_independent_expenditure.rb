require 'test_helper'

class TestCampaignCash::TestIndependentExpenditure < Test::Unit::TestCase
	include CampaignCash
		
	context "independent expenditures" do
	  setup do
			@independent_expenditures = IndependentExpenditure.latest
	  end
	  
		should "return a list of objects of the IndependentExpenditure type" do
			assert_kind_of(IndependentExpenditure, @independent_expenditures.first)
		end
	end
end