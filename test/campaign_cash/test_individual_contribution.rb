require 'test_helper'

class TestCampaignCash::TestIndividualContribution < Test::Unit::TestCase
	include CampaignCash
  
	context "get contributions" do
	  objs_collection = []
	  objs_collection << IndividualContribution.committee("C00496497")
	  objs_collection << IndividualContribution.filing("724196")
	  
	  should "return a list of objects of the IndividualContribution type from a committee or an empty list" do
      if objs_collection.first.size > 0
        assert_kind_of(IndividualContribution, objs_collection.first)
      else
        assert_equal([], objs_collection.first)
      end
    end

    should "return a list of objects of the IndividualContribution type from a filing or an empty list for a cmte" do
      if objs_collection[1].size > 0
        assert_kind_of(IndividualContribution, objs_collection[1])
      else
        assert_equal([], objs_collection[1])
      end
    end
  end  	
end