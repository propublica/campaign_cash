require 'test_helper'

class TestCampaignCash::TestIndividualContribution < Test::Unit::TestCase
	include CampaignCash
  
	should "get contributions" do
	  objs_collection = []
	  objs_collection << IndividualContribution.committee("C00496497")
	  objs_collection << IndividualContribution.filing("724196")
	  objs_collection << IndividualContribution.candidate("P80003353")
	  
	  objs_collection.each do |objs|
	    should "return a list of objects of the IndividualContribution type or an empty list" do
  		  if objs.size > 0
  			  assert_kind_of(IndividualContribution, objs.first)
  			else
  			  assert_equal([], objs)
  			end
  		end
    end
  end  	
end