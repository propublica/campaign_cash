require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'mocha'
require 'json'

require File.dirname(__FILE__) + '/../lib/campaign_cash'
require File.dirname(__FILE__) + '/../lib/campaign_cash/base'
require File.dirname(__FILE__) + '/../lib/campaign_cash/candidate'
require File.dirname(__FILE__) + '/../lib/campaign_cash/committee'

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
                "committee_loans"=>nil, "status"=>"I", "total_from_pacs"=>320917.0, "state"=>"/seats/NY.json", "total_contributions"=>964166.0, 
                "fec_uri"=>"http://query.nictusa.com/cgi-bin/fecimg/?H4NY07011"}
                
CANDIDATE_RESULT_HASH = {
	"status" => "OK",
	"copyright" => "Copyright (c) 2010 The New York Times Company.  All Rights Reserved.",
	"num_results" => 1,
	"results" => [CANDIDATE_HASH]
}

CANDIDATE_HASH_REPLY = CANDIDATE_RESULT_HASH.to_json

CANDIDATE_SEARCH_HASH = [{"district"=>"/seats/NM/senate.json", "candidate"=>{"name"=>"UDALL, TOM", "id"=>"S8NM00184", 
                    "relative_uri"=>"/committees/S8NM00184.json", "party"=>"DEM"}, "committee"=>"/committees/C00329896.json", 
                    "state"=>"/seats/NM.json"}, {"district"=>"/seats/CO/house/02.json", "candidate"=>{"name"=>"UDALL, MARK E.", 
                    "id"=>"H8CO02087", "relative_uri"=>"/committees/H8CO02087.json", "party"=>"DEM"}, "committee"=>"/committees/C00331439.json", 
                    "state"=>"/seats/CO.json"}]

CANDIDATE_SEARCH_RESULT_HASH = {
	"status" => "OK",
	"copyright" => "Copyright (c) 2010 The New York Times Company.  All Rights Reserved.",
	"num_results" => 2,
	"results" => CANDIDATE_SEARCH_HASH
}

NEW_CANDIDATES_HASH = [{"mailing_state"=>"PA", "name"=>"SCARINGI, MARC ANTHONY", "mailing_city"=>"CAMP HILL", "district"=>"/seats/PA/senate.json", 
  "mailing_zip"=>"17011", "id"=>"S0PA00491", "relative_uri"=>"/committees/S0PA00491.json", "committee"=>nil, "party"=>"REP", "state"=>"/seats/PA.json", 
  "fec_uri"=>"http://query.nictusa.com/cgi-bin/fecimg/?S0PA00491"}, {"mailing_state"=>"TX", "name"=>"MORENOFF, DAN", "mailing_city"=>"DALLAS", 
  "district"=>nil, "mailing_zip"=>"75201", "id"=>"H2TX00106", "relative_uri"=>"/committees/H2TX00106.json", "committee"=>"/committees/C00491308.json", 
  "party"=>"REP", "state"=>"/seats/TX.json", "fec_uri"=>"http://query.nictusa.com/cgi-bin/fecimg/?H2TX00106"}, {"mailing_state"=>"MT",
  "name"=>"DAINES, STEVEN", "mailing_city"=>"BOZEMAN", "district"=>"/seats/MT/senate.json", "mailing_zip"=>"59705", "id"=>"S2MT00096", 
  "relative_uri"=>"/committees/S2MT00096.json", "committee"=>"/committees/C00491357.json", "party"=>"REP", "state"=>"/seats/MT.json", 
  "fec_uri"=>"http://query.nictusa.com/cgi-bin/fecimg/?S2MT00096"}, {"mailing_state"=>"AK", "name"=>"CRAWFORD, HARRY T JR", "mailing_city"=>"ANCHORAGE", 
  "district"=>nil, "mailing_zip"=>"99504", "id"=>"H0AK00089", "relative_uri"=>"/committees/H0AK00089.json", "committee"=>"/committees/C00466698.json", 
  "party"=>"DEM", "state"=>"/seats/AK.json", "fec_uri"=>"http://query.nictusa.com/cgi-bin/fecimg/?H0AK00089"}]
  
NEW_CANDIDATES_RESULT_HASH = {
	"status" => "OK",
	"copyright" => "Copyright (c) 2010 The New York Times Company.  All Rights Reserved.",
	"num_results" => 4,
	"results" => NEW_CANDIDATES_HASH
}

CANDIDATE_LEADERS_HASH = [{"name"=>"SHELBY, RICHARD C", "begin_cash"=>13381000.0, "total_from_individuals"=>2998770.0, "date_coverage_to"=>"2010-10-13", 
                         "total_disbursements"=>1457040.0, "total_refunds"=>25800.0, "district"=>"00", "end_cash"=>17028200.0, "relative_uri"=>"/candidates/S6AL00013.json", 
                         "date_coverage_from"=>"2009-01-01", "committee"=>"/committees/C00193623.json", "party"=>"REP", "debts_owed"=>nil, "candidate_loans"=>nil, 
                         "status"=>"I", "total_from_pacs"=>1563800.0, "state"=>"/seats/AL.json", "total_contributions"=>4561570.0}, {"name"=>"SCHUMER, CHARLES E", 
                         "begin_cash"=>10571100.0, "total_from_individuals"=>13412700.0, "date_coverage_to"=>"2010-10-13", "total_disbursements"=>11824600.0, 
                         "total_refunds"=>58350.0, "district"=>"00", "end_cash"=>16048500.0, "relative_uri"=>"/candidates/S8NY00082.json", "date_coverage_from"=>"2009-01-01", 
                         "committee"=>"/committees/C00346312.json", "party"=>"DEM", "debts_owed"=>nil, "candidate_loans"=>nil, "status"=>"I", "total_from_pacs"=>2792880.0, 
                         "state"=>"/seats/NY.json", "total_contributions"=>16205600.0}, {"name"=>"THUNE, JOHN", "begin_cash"=>3900450.0, "total_from_individuals"=>4148020.0, 
                         "date_coverage_to"=>"2010-10-13", "total_disbursements"=>2988650.0, "total_refunds"=>33697.0, "district"=>"00", "end_cash"=>7194550.0, 
                         "relative_uri"=>"/candidates/S2SD00068.json", "date_coverage_from"=>"2009-01-01", "committee"=>"/committees/C00409581.json", "party"=>"REP", 
                         "debts_owed"=>nil, "candidate_loans"=>nil, "status"=>"I", "total_from_pacs"=>1897980.0, "state"=>"/seats/SD.json", "total_contributions"=>5951400.0}, 
                         {"name"=>"BROWN, SCOTT P", "begin_cash"=>nil, "total_from_individuals"=>16532700.0, "date_coverage_to"=>"2010-09-30", "total_disbursements"=>10757100.0, 
                         "total_refunds"=>34993.0, "district"=>"00", "end_cash"=>6770800.0, "relative_uri"=>"/candidates/S0MA00109.json", "date_coverage_from"=>"2009-09-14", 
                         "committee"=>"/committees/C00467233.json", "party"=>"REP", "debts_owed"=>nil, "candidate_loans"=>nil, "status"=>"I", "total_from_pacs"=>670892.0, 
                         "state"=>"/seats/MA.json", "total_contributions"=>17229100.0}]

CANDIDATE_LEADERS_RESULT_HASH = {
	"status" => "OK",
	"copyright" => "Copyright (c) 2010 The New York Times Company.  All Rights Reserved.",
	"num_results" => 4,
	"results" => CANDIDATE_LEADERS_HASH
}

COMMITTEE_HASH = {"name"=>"BLUE CROSS AND BLUE SHIELD OF NORTH CAROLINA EMPLOYEE POLITICAL ACTION COMMITTEE", "address"=>"P.O. Box 2291", "city"=>"Durham", 
                "begin_cash"=>18098.1, "total_from_individuals"=>205135.0, "zip"=>"27702", "date_coverage_to"=>"2010-10-13", "total_disbursements"=>203640.0, 
                "total_receipts"=>205135.0, "total_refunds"=>769.57, "treasurer"=>"Wright, Kenneth", "end_cash"=>19593.7, "id"=>"C00312223", 
                "date_coverage_from"=>"2009-01-01", "candidate"=>nil, "party"=>"", "debts_owed"=>0.0, 
                "total_from_pacs"=>0.0, "state"=>"NC", "total_contributions"=>205135.0, "fec_uri"=>"http://query.nictusa.com/cgi-bin/dcdev/forms/C00312223/"}
                
COMMITTEE_SEARCH_RESULT_HASH = {
  "status" => "OK",
	"copyright" => "Copyright (c) 2010 The New York Times Company.  All Rights Reserved.",
	"num_results" => 1,
	"results" => [COMMITTEE_HASH]
}
NEW_COMMITTEES_HASH = [{"name"=>"REDWHITEANDTRUEBLUE.US", "address"=>"1110 CUMMINGS AVE", "city"=>"COPPERAS COVE", "zip"=>"76522", "treasurer"=>"WILLIAM THOMAS", 
                            "id"=>"C00491266", "relative_uri"=>"/committees/C00491266.json", "candidate"=>nil, "party"=>"", "state"=>"TX", "fec_uri"=>"http://query.nictusa.com/cgi-bin/dcdev/forms/C00491266/"}, 
                            {"name"=>"LIBERTY COALITION PAC DBA OREGON TEA PARTY", "address"=>"PO BOX 25313", "city"=>"PORTLAND", "zip"=>"97298", "treasurer"=>"GEOFF LUDT", 
                            "id"=>"C00491274", "relative_uri"=>"/committees/C00491274.json", "candidate"=>nil, "party"=>"", "state"=>"OR", "fec_uri"=>"http://query.nictusa.com/cgi-bin/dcdev/forms/C00491274/"}, 
                            {"name"=>"REPUBLICAN INDIAN COMMITTEE PAC", "address"=>"10319 WESTLAKE DRIVE SUITE #234", "city"=>"BETHESDA", "zip"=>"20817", "treasurer"=>"JODY VENKATESAN", 
                            "id"=>"C00491282", "relative_uri"=>"/committees/C00491282.json", "candidate"=>nil, "party"=>"", "state"=>"MD", "fec_uri"=>"http://query.nictusa.com/cgi-bin/dcdev/forms/C00491282/"}, 
                            {"name"=>"TEA PARTY NATION", "address"=>"1155 15TH STREET NW SUITE 410", "city"=>"WASHINGTON", "zip"=>"20005", "treasurer"=>"SCOTT B MACKENZIE", 
                            "id"=>"C00491290", "relative_uri"=>"/committees/C00491290.json", "candidate"=>nil, "party"=>"", "state"=>"DC", "fec_uri"=>"http://query.nictusa.com/cgi-bin/dcdev/forms/C00491290/"}] 

NEW_COMMITTEES_RESULT_HASH = {
	"status" => "OK",
	"copyright" => "Copyright (c) 2010 The New York Times Company.  All Rights Reserved.",
	"num_results" => 4,
	"results" => NEW_COMMITTEES_HASH
}