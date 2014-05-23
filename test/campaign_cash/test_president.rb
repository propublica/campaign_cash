require 'test_helper'

class TestCampaignCash::TestPresident < Minitest::Test
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

		%w(name total_contributions total_receipts).each do |attr|
			should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
				assert_equal(@results.first[attr], @summary.send(attr))
			end
		end

		should "assign the office to 'president'" do
			assert_equal('president', @summary.office)
		end

		should "assign the party to 'REP' if the candidate is republican or 'DEM' if democrat" do
		    party = @results.first['party']
		    party = "REP" if party == "R"
		    party = "DEM" if party == "D"
		    assert_equal(party, @summary.party)
		end

  end

	context "President.detail" do
		setup do
		  reply = Base.invoke('2012/president/candidates/C00496034', {})
			@results = reply['results']
			@detail = President.create_detail(@results.first)
		end

		should "return an array of objects of the President type" do
			assert_kind_of(President, @detail)
		end

		%w(net_primary_contributions total_refunds).each do |attr|
			should "assign the value of the @#{attr} attribute from the '#{attr}' key in the hash" do
				assert_equal(@results.first[attr], @detail.send(attr))
			end
		end

		should "assign the office to 'president'" do
			assert_equal('president', @detail.office)
		end

		should "assign the party to 'REP' if the candidate is republican or 'DEM' if democrat" do
		    party = @results.first['party']
		    party = "REP" if party == "R"
		    party = "DEM" if party == "D"
		    assert_equal(party, @detail.party)
		end
    end
end