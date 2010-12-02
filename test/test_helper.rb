require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'fake_web'
require 'mocha'
require 'json'

require File.dirname(__FILE__) + '/../lib/campaign_cash'

API_KEY = '13e234323232222'
CampaignCash::Base.api_key = API_KEY

def api_url_for(path, params = {})
	full_params = params.merge 'api-key' => API_KEY
	CampaignCash::Base.build_request_url(path, full_params).to_s
end

module TestCampaignCash
end

CANDIDATE_HASH = {"mailing_state"=>"NY", "mailing_address"=>"113 Deer Run", "name"=>"ACKERMAN, GARY L.", "mailing_city"=>"Roslyn Heights", 
                "begin_cash"=>1164090.0, "total_from_individuals"=>643249.0, "date_coverage_to"=>"2010-10-13", "total_disbursements"=>1305560.0,
                "total_receipts"=>993067.0, "total_refunds"=>nil, "district"=>"/seats/NY/house/05.json", "end_cash"=>851590.0, "mailing_zip"=>"11577", 
                "id"=>"H4NY07011", "date_coverage_from"=>"2009-01-01", "committee"=>"/committees/C00165241.json", "party"=>"DEM", "debts_owed"=>nil, 
                "candidate_loans"=>nil, "status"=>"I", "total_from_pacs"=>320917.0, "state"=>"/seats/NY.json", "total_contributions"=>964166.0, 
                "fec_uri"=>"http://query.nictusa.com/cgi-bin/fecimg/?H4NY07011"}
                
CANDIDATE_RESULT_HASH = {
	"status" => "OK",
	"copyright" => "Copyright (c) 2010 The New York Times Company.  All Rights Reserved.",
	"num_results" => 1,
	"results" => [CANDIDATE_HASH]
}

CANDIDATE_HASH_REPLY = CANDIDATE_RESULT_HASH.to_json

CANDIDATE_SEARCH_HASH = [{"district"=>"/seats/NM/senate.json", "candidate"=>{"name"=>"UDALL, TOM", "id"=>"S8NM00184", 
                    "relative_uri"=>"/candidates/S8NM00184.json", "party"=>"DEM"}, "committee"=>"/committees/C00329896.json", 
                    "state"=>"/seats/NM.json"}, {"district"=>"/seats/CO/house/02.json", "candidate"=>{"name"=>"UDALL, MARK E.", 
                    "id"=>"H8CO02087", "relative_uri"=>"/candidates/H8CO02087.json", "party"=>"DEM"}, "committee"=>"/committees/C00331439.json", 
                    "state"=>"/seats/CO.json"}]

CANDIDATE_SEARCH_RESULT_HASH = {
	"status" => "OK",
	"copyright" => "Copyright (c) 2010 The New York Times Company.  All Rights Reserved.",
	"num_results" => 2,
	"results" => CANDIDATE_SEARCH_HASH
}