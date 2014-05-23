require 'test_helper'

class TestCampaignCash::TestCommittee < Minitest::Test
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
		  @committees = Committee.search("Obama for America", 2012)
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
	    @filings = results.map{|f| Filing.create(f)}
	  end
	  
	  should "return 11 filings" do
	    assert_equal @filings.size, 11
	  end
	end
	
	context "committee unamended filings" do
	  setup do
	    reply = Base.invoke('2012/committees/C00431171/filings', {})
	    results = reply['results'].select{|f| f['amended'] == false}
	    @filings = results.map{|f| Filing.create(f)}
	  end
	  
	  should "return filings that are not amended" do
	    assert_equal @filings.select{|f| f.amended == true}.size, 0
	  end
	end

	context "committee detail" do
	  setup do
	    @committee = Committee.find('C00084475', 2012)
	  end
	  
	  should "return 17 other cycles" do
	    assert_equal @committee.other_cycles.size, 17
	  end
	end
	
	context "committee contributions" do
	  setup do
	    @contribution = Contribution.find('C00458588', 2010)
	  end
	  
	  should "return 141 total results" do
	    assert_equal @contribution.total_results, 141
	  end
	  
	  should "return a $5,000 contribution to Renee Ellmers" do
	    assert_equal @contribution.results.detect{|c| c.candidate == "H0NC02059"}.amount, 5000
	  end
	  
	end
	
	context "committee contributions to a candidate" do
	  setup do
	    reply = Base.invoke('2010/committees/C00458588/contributions/candidates/H0NC02059', {})
	    @contribution = Contribution.to_candidate(reply)
	  end
	  
	  should "return 2 results totaling $10,000" do
	    assert_equal @contribution.results.size, 2
	    assert_equal @contribution.total_amount, 10000
	  end
	end
	
	context "superpacs" do
	  setup do
	    reply = Base.invoke('2012/committees/superpacs')
	    @committees = reply['results'].map{|c| Committee.create_from_search_results(c) }
	  end
	  
	  should "return an array of super pacs" do
	    assert_equal([true], @committees.map{|c| c.super_pac }.uniq)
	  end
	end
	
end