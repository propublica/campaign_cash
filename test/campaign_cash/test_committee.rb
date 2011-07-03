require 'test_helper'

class TestCampaignCash::TestCommittee < Test::Unit::TestCase
	include CampaignCash
	
	context "Committee.create_from_api" do
		setup do
		  reply = Base.invoke('2010/committees/C00312223', {})
			@result = reply['results'].first
			@committee = Committee.create(@result)
		end
		
		should "return an object of the Committee type" do
			assert_kind_of(Committee, @committee)
		end
		
		%w(name id state party fec_uri candidate).each do |attr|
			should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
				assert_equal(@result[attr], @committee.send(attr))
			end
		end
	end
	
	context "Committee search" do
	  setup do
		  reply = Base.invoke('2010/committees/search', {:query => "Boeing"})
			results = reply['results']
	    @committees = results.map{|c| Committee.create_from_search_results(c)}
	  end
	  
	  should "return two committee objects" do
	    assert_equal @committees.size, 1
	    assert_kind_of(Committee, @committees.first)
	    assert_kind_of(Committee, @committees.last)
	  end
	end
	
	context "New Committees" do
	  setup do
		  reply = Base.invoke('2010/committees/new', {})
			results = reply['results']
	    @committees = results.map{|c| Committee.create_from_search_results(c)}
	  end
	  
	  should "return 20 new committees" do
	    assert_equal @committees.size, 20
	    assert_kind_of(Committee, @committees.first)
	    assert_kind_of(Committee, @committees.last)
	  end
	end
	
	context "committee filings" do
	  setup do
	    reply = Base.invoke('2010/committees/C00312223/filings', {})
	    results = reply['results']
	    @filings = results.map{|f| Filing.create_from_filings(f)}
	  end
	  
	  should "return 11 filings" do
	    assert_equal @filings.size, 11
	  end
	end

	context "committee detail" do
	  setup do
	    @committee = Committee.find('C00084475', 2012)
	  end
	  
	  should "return 16 other cycles" do
	    assert_equal @committee.other_cycles.size, 16
	  end
	end
	
	context "committee contributions" do
	  setup do
	    @contribution = Contribution.find('C00458588', 2010)
	  end
	  
	  should "return 125 total results" do
	    assert_equal @contribution.total_results, 125
	  end
	  
	  should "return a $5,000 contribution to Renee Ellmers" do
	    assert_equal @contribution.results.detect{|c| c.candidate_uri == "/candidates/H0NC02059.json"}.amount, 5000
	  end
	  
	end
	
	context "committee contributions to a candidate" do
	  setup do
	    reply = Base.invoke('2010/committees/C00458588/contributions/candidates/H0NC02059', {})
	    @contribution = Contribution.create(reply)
	  end
	  
	  should "return 2 results totaling $10,000" do
	    assert_equal @contribution.results.size, 2
	    assert_equal @contribution.total_amount, 10000
	  end
	end
end