require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCampaignCash::TestCommittee < Test::Unit::TestCase
	include CampaignCash
	
	context "Committee.create_from_api" do
		setup do
		  reply = Base.invoke('2010/committees/C00312223', {})
			@result = reply['results'].first
			@committee = Committee.create_from_api(@result)
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
	    @committees = results.map{|c| Committee.create_from_api_search_results(c)}
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
	    @committees = results.map{|c| Committee.create_from_api_search_results(c)}
	  end
	  
	  should "return 20 new committees" do
	    assert_equal @committees.size, 20
	    assert_kind_of(Committee, @committees.first)
	    assert_kind_of(Committee, @committees.last)
	  end
	end

	context "request with missing id" do
	  should "return an error" do
	    assert_raise RuntimeError do
	      Base.invoke('2010/committees/', {})
	    end
	  end
	end
end