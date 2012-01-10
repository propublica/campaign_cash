require 'test_helper'

class TestCampaignCash::TestCandidate < Test::Unit::TestCase
	include CampaignCash
	
	context "Candidate.create" do
		setup do
		  reply = Base.invoke('2010/candidates/H4NY07011', {})
			@result = reply['results'].first
			@candidate = Candidate.create(@result)
		end
		
		should "return an object of the Candidate type" do
			assert_kind_of(Candidate, @candidate)
		end
		
		%w(name id party fec_uri).each do |attr|
			should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
				assert_equal(@result[attr], @candidate.send(attr))
			end
		end
  end
	
	context "Candidate search" do
	  setup do
		  reply = Base.invoke('2010/candidates/search', {:query => "Udall"})
			results = reply['results']
	    @candidates = results.map{|c| Candidate.create_from_search_results(c)}
	  end
	  
	  should "return two candidate objects" do
	    assert_equal @candidates.size, 2
	    assert_kind_of(Candidate, @candidates.first)
	    assert_kind_of(Candidate, @candidates.last)
	  end
	end
	
	context "New Candidates" do
	  setup do
		  reply = Base.invoke('2012/candidates/new', {})
			results = reply['results']
	    @candidates = results.map{|c| Candidate.create(c)}
	  end
	  
	  should "return 20 new candidates" do
	    assert_equal @candidates.size, 20
	    assert_kind_of(Candidate, @candidates.first)
	    assert_kind_of(Candidate, @candidates.last)
	  end
	end
	
	context "candidate leaders" do
	  setup do
		  reply = Base.invoke('2010/candidates/leaders/end-cash', {})
			results = reply['results']
	    @candidates = results.map{|c| Candidate.create(c)}
	  end
	  
	  should "return 20 candidates each with a greater end_cash value than the next" do
	    assert (@candidates[0].end_cash >= @candidates[1].end_cash)
	    assert (@candidates[1].end_cash >= @candidates[2].end_cash)
	    assert (@candidates[2].end_cash >= @candidates[3].end_cash)
	  end
	end
		
	context "state candidates" do
	  setup do
		  @candidates = Candidate.state_chamber('RI', 'house', nil, 2010)
	  end
	  
	  should "return 29 House candidates from Rhode Island" do
	    assert_equal @candidates.size, 29
	  end
	end
end