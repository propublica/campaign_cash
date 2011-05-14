module CampaignCash
  class Candidate < Base
    
    # Represents a candidate object based on the FEC's candidate and candidate summary files.
    # A candidate is a person seeking a particular office within a particular two-year election
    # cycle. Each candidate is assigned a unique ID within a cycle.
    attr_reader :name, :id, :state, :district, :party, :fec_uri, :committee, 
                :mailing_city, :mailing_address, :mailing_state, :mailing_zip,
                :total_receipts, :total_contributions, :total_from_individuals, 
                :total_from_pacs, :candidate_loans, :total_disbursements,
                :total_refunds, :debts_owed, :begin_cash, :end_cash, :status,
                :date_coverage_to, :date_coverage_from, :relative_uri
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
    # Creates a new candidate object from a JSON API response.
		def self.create(params={})
			self.new :name => params['name'],
							 :id => params['id'],
							 :state => params['state'],
							 :district => params['district'],
							 :party => params['party'],
							 :fec_uri => params['fec_uri'],
							 :committee => params['committee'],
							 :mailing_city => params['mailing_city'],
							 :mailing_address => params['mailing_address'],
							 :mailing_state => params['mailing_state'],
							 :mailing_zip => params['mailing_zip'],
							 :total_receipts => params['total_receipts'],
							 :total_contributions => params['total_contributions'],
							 :total_from_individuals => params['total_from_individuals'],
							 :total_from_pacs => params['total_from_pacs'],
							 :candidate_loans => params['candidate_loans'],
							 :total_disbursements => params['total_disbursements'],
							 :total_refunds => params['total_refunds'],
							 :debts_owed => params['debts_owed'],
							 :begin_cash => params['begin_cash'],
							 :end_cash => params['end_cash'],
							 :status => params['status'],
							 :date_coverage_from => params['date_coverage_from'],
							 :date_coverage_to => params['date_coverage_to'] 
		end
		
		def self.create_from_search_results(params={})
		  self.new :name => params['candidate']['name'],
		           :id => params['candidate']['id'],
		           :state => params['state'],
		           :district => params['district'],
		           :party => params['candidate']['party'],
		           :relative_uri => params['candidate']['relative_uri'],
		           :committee => params['committee']
		  
		end
		
		# Retrieve a candidate object via its FEC candidate id within a cycle.
		# Defaults to the current cycle.
    def self.find(fecid, cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/candidates/#{fecid}")
			result = reply['results']
			self.create(result.first) if result.first
    end
    
    # Returns leading candidates for given categories from campaign filings within a cycle.
    # See [the API docs](http://developer.nytimes.com/docs/read/campaign_finance_api#h3-candidate-leaders) for
    # a list of acceptable categories to pass in. Defaults to the current cycle.
    def self.leaders(category, cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/candidates/leaders/#{category}",{})
			results = reply['results']
      results.map{|c| self.create(c)}
    end
    
    # Returns an array of candidates matching a search term within a cycle. Defaults to the
    # current cycle.
    def self.search(name, cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/candidates/search", {:query => name})
			results = reply['results']      
      results.map{|c| self.create_from_search_results(c)}
    end
    
    # Returns an array of newly created FEC candidates within a current cycle. Defaults to the
    # current cycle.
    def self.new_candidates(cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/candidates/new",{})
			results = reply['results']      
      results.map{|c| self.create(c)}      
    end
    
    # Returns an array of candidates for a given state and chamber within a cycle, with an optional
    # district parameter. For example, House candidates from New York. Defaults to the current cycle.
    def self.state_chamber(state, chamber, district=nil, cycle=CURRENT_CYCLE)
      district ? path = "#{cycle}/seats/#{state}/#{chamber}/#{district}" : path = "#{cycle}/seats/#{state}/#{chamber}"
			reply = invoke(path,{})
			results = reply['results']
      results.map{|c| self.create_from_search_results(c)}      
    end
    
  end
end
