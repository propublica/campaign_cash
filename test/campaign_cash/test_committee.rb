require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCampaignCash::TestCommittee < Test::Unit::TestCase
	include CampaignCash
	
	context "Committee.create_from_api" do
		setup do
			@committee = Committee.create_from_api(COMMITTEE_HASH)
		end
		
		should "return an object of the Committee type" do
			assert_kind_of(Committee, @committee)
		end
		
		%w(name id state district party fec_uri committee).each do |attr|
			should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
				assert_equal(COMMITTEE_HASH[attr], @committee.send(attr))
			end
		end
	end
	
	context "Committee search" do
	  setup do
	    results = COMMITTEE_SEARCH_RESULT_HASH['results']
	    @committees = results.map{|c| Committee.create_from_api_search_results(c)}
	  end
	  
	  should "return two committee objects" do
	    assert_equal @committees.size, 2
	    assert_kind_of(Committee, @committees.first)
	    assert_kind_of(Committee, @committees.last)
	  end
	end
	
	context "New Committees" do
	  setup do
	    results = NEW_COMMITTEES_RESULT_HASH['results']
	    @committees = results.map{|c| Committee.create_from_api(c)}
	  end
	  
	  should "return 4 new committees" do
	    assert_equal @committees.size, 4
	    assert_kind_of(Committee, @committees.first)
	    assert_kind_of(Committee, @committees.last)
	  end
	end
			
end