require File.dirname(__FILE__) + '/../test_helper.rb'

class TestCampaignCash::TestCandidate < Test::Unit::TestCase
	include CampaignCash
	
	# global setup
	def setup
		FakeWeb.clean_registry
		FakeWeb.register_uri(Base::API_SERVER, :body => nil, :status => [])
	end
	
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
			
end