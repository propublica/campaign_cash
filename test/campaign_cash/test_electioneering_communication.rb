require 'test_helper'

class TestCampaignCash::TestElectioneeringCommunication < Minitest::Test
  include CampaignCash
  
  context "get electioneering communications" do
    latest = ElectioneeringCommunication.latest
    committee = ElectioneeringCommunication.committee("C30001655")
    date = ElectioneeringCommunication.date("02/06/2012")

    should "return a list of latest objects of the ElectioneeringCommunication type or an empty list" do
      if latest.size > 0
        assert_kind_of(ElectioneeringCommunication, latest.first)
      else
        assert_equal([], latest)
      end
    end

    should "return a list of objects of the ElectioneeringCommunication type or an empty list for a cmte" do
      if committee.size > 0
        assert_kind_of(ElectioneeringCommunication, committee.first)
      else
        assert_equal([], committee)
      end
    end

    should "return a list of latest objects of the ElectioneeringCommunication type or an empty list by date" do
      if date.size > 0
        assert_kind_of(ElectioneeringCommunication, date.first)
      else
        assert_equal([], date)
      end
    end
  end   
end