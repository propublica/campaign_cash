require 'test_helper'

class TestCampaignCash::TestElectioneeringCommunication < Test::Unit::TestCase
  include CampaignCash
  
  context "get electioneering communications" do
    objs_collection = []
    objs_collection << ElectioneeringCommunication.latest
    objs_collection << ElectioneeringCommunication.committee("C30001655")
    objs_collection << ElectioneeringCommunication.date("2012", "02", "06")
    
    objs_collection.each do |objs|
      should "return a list of objects of the ElectioneeringCommunication type or an empty list" do
        if objs.size > 0
          assert_kind_of(ElectioneeringCommunication, objs.first)
        else
          assert_equal([], objs)
        end
      end
    end
  end   
end