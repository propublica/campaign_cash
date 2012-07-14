require 'test_helper'

class TestCampaignCash::TestLateContribution < Test::Unit::TestCase
	include CampaignCash
  
	context "get late contributions" do
	  objs_collection = []
	  objs_collection << LateContribution.committee("C00505255")
	  objs_collection << LateContribution.latest
	  objs_collection << LateContribution.candidate("H2NC09092")
	  
	  objs_collection.each do |objs|
	    should "return a list of objects of the IndividualContribution type or an empty list" do
  		  if objs.size > 0
  		    objs.each do |obj|
  		      assert_kind_of(LateContribution, obj)
  		    end
  			else
  			  assert_equal([], objs)
  			end
  		end
    end
  end  	
end