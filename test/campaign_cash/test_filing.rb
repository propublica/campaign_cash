require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCampaignCash::TestFiling < Test::Unit::TestCase
	include CampaignCash
	
	context "a day" do
	  setup do
	    month, day, year = "11", "27", "2010"
		  reply = Base.invoke("2010/filings/#{year}/#{month}/#{day}", {})
		  @results = reply['results']
			@filings = @results.map{|c| Filing.create_from_api(c)}
	  end
	  
		should "return a list of objects of the Filing type" do
			assert_kind_of(Filing, @filings.first)
		end
		
		%w(committee_name fec_uri committee amended).each do |attr|
			should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
				assert_equal(@results.first[attr], @filings.first.send(attr))
			end
		end
	end
	
	context "today's filings" do
	  setup do
		  reply = Base.invoke('2010/filings', {})
		  @results = reply['results']
			@filings = @results.map{|c| Filing.create_from_api(c)}
	  end
	  
		should "return a list of objects of the Filing type" do
			assert_kind_of(Filing, @filings.first)
		end
	end
	
end