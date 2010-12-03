require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCampaignCash::TestCandidate < Test::Unit::TestCase
	include CampaignCash
	
	context "Candidate.create_from_api" do
		setup do
			@candidate = Candidate.create_from_api(CANDIDATE_HASH)
		end
		
		should "return an object of the Candidate type" do
			assert_kind_of(Candidate, @candidate)
		end
		
		%w(name id state district party fec_uri committee).each do |attr|
			should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
				assert_equal(CANDIDATE_HASH[attr], @candidate.send(attr))
			end
		end
	end
	
	context "Candidate search" do
	  setup do
	    results = CANDIDATE_SEARCH_RESULT_HASH['results']
	    @candidates = results.map{|c| Candidate.create_from_api_search_results(c)}
	  end
	  
	  should "return two candidate objects" do
	    assert_equal @candidates.size, 2
	    assert_kind_of(Candidate, @candidates.first)
	    assert_kind_of(Candidate, @candidates.last)
	  end
	end
	
	context "New Candidates" do
	  setup do
	    results = NEW_CANDIDATES_RESULT_HASH['results']
	    @candidates = results.map{|c| Candidate.create_from_api(c)}
	  end
	  
	  should "return 4 new candidates" do
	    assert_equal @candidates.size, 4
	    assert_kind_of(Candidate, @candidates.first)
	    assert_kind_of(Candidate, @candidates.last)
	  end
	end
	
	context "candidate leaders" do
	  setup do
	    results = CANDIDATE_LEADERS_RESULT_HASH['results']
	    @candidates = results.map{|c| Candidate.create_from_api(c)}
	  end
	  
	  should "return 4 candidates each with a greater end_cash value than the next" do
	    assert (@candidates[0].end_cash >= @candidates[1].end_cash)
	    assert (@candidates[1].end_cash >= @candidates[2].end_cash)
	    assert (@candidates[2].end_cash >= @candidates[3].end_cash)
	  end
	end
end