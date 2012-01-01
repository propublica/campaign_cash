require 'test_helper'

class TestCampaignCash::TestPresident < Test::Unit::TestCase
	include CampaignCash
	
	context "President.summary" do
		setup do
		  reply = Base.invoke('2012/president/totals', {})
			@results = reply['results']
			@summaries = @results.map{|r| President.create_summary(r)}
			@summary = @summaries.first
		end
		
		should "return an array of objects of the President type" do
			assert_kind_of(President, @summary)
		end
		
		%w(name total_contributions party total_receipts).each do |attr|
			should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
				assert_equal(@results.first[attr], @summary.send(attr))
			end
		end
  end

	
	
end