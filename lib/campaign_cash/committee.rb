module CampaignCash
  class Committee < Base
    
    attr_reader :name, :id, :state, :district, :party, :fec_uri, :candidate, 
                :city, :address, :state, :zip, :relative_uri,
                :total_receipts, :total_contributions, :total_from_individuals, 
                :total_from_pacs, :candidate_loans, :total_disbursements,
                :total_refunds, :debts_owed, :begin_cash, :end_cash,
                :date_coverage_to, :date_coverage_from
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
		def self.create(params={})
			self.new :name => params['name'],
							 :id => params['id'],
							 :state => params['state'],
							 :party => params['party'],
							 :fec_uri => params['fec_uri'],
							 :city => params['city'],
							 :address => params['address'],
							 :zip => params['zip'],
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
							 :date_coverage_from => params['date_coverage_from'],
							 :date_coverage_to => params['date_coverage_to'],
							 :candidate => params['candidate']
		end
		
		def self.create_from_search_results(params={})
		  self.new :name => params['name'],
		           :id => params['id'],
		           :city => params['city'],
		           :state => params['state'],
		           :zip => params['zip'],
		           :district => params['district'],
		           :party => params['party'],
		           :relative_uri => params['relative_uri'],
		           :candidate => params['candidate'],
		           :treasurer => params['treasurer']
		  
		end
    
    def self.find(fecid, cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/committees/#{fecid}")
			result = reply['results']
			self.create_from_api(result.first) if result.first
    end
    
    def self.search(name, cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/committees/search", {:query => name})
			results = reply['results']      
      results.map{|c| self.create_from_api_search_results(c)}
    end
    
    def self.new_committees(cycle=CURRENT_CYCLE)
			reply = invoke("#{cycle}/committees/new",{})
			results = reply['results']      
      results.map{|c| self.create_from_api(c)}      
    end
    
  end
end
