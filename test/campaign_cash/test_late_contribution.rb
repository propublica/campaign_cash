require 'test_helper'

class TestCampaignCash::TestLateContribution < Minitest::Test
	include CampaignCash
  
	context "get late contributions" do
	  cmte = LateContribution.committee("C00505255")
	  cand = LateContribution.candidate("H2NC09092")
	  
    should "return a list of objects of the LateContribution type from a committee or an empty list" do
      if cmte.size > 0
        assert_kind_of(LateContribution, cmte.first)
      else
        assert_equal([], cmte)
      end
    end

    should "return a list of objects of the LateContribution type from a candidate or an empty list for a cmte" do
      if cand.size > 0
        assert_kind_of(LateContribution, cand.first)
      else
        assert_equal([], cand)
      end
    end
  end  	
end