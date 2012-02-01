module CampaignCash
  class President < Base
      
    attr_reader :committee_id, :name, :id, :party, :office, :date_coverage_from, :date_coverage_to, :total_receipts, :total_disbursements,
                :end_cash, :total_refunds, :total_contributions, :net_individual_contributions, :net_pac_contributions, 
                :net_party_contributions, :net_candidate_contributions, :net_primary_contributions, :net_general_contributions,
                :federal_funds, :contributions_less_than_200, :contributions_200_499, :contributions_500_1499, :contributions_1500_2499,
                :contributions_max
      
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
    # Creates a new president summary object from a JSON API presidential response.
		def self.create_summary(params={})
			self.new :name => params['name'],
							 :id => params['candidate_id'],
							 :party => get_party(params['party']),
							 :office => 'president',
							 :committee_id => params['committee_id'],
							 :total_receipts => params['total_receipts'],
							 :total_disbursements => params['total_disbursements'],
							 :end_cash => params['cash_on_hand'],
							 :date_coverage_from => params['date_coverage_from'],
							 :date_coverage_to => params['date_coverage_to']
		end
		
		# Creates a detailed president object
		def self.create_detail(params={})
			self.new :name => params['candidate_name'],
							 :id => params['candidate_id'],
							 :party => get_party(params['party']),
							 :office => 'president',
							 :committee_id => params['committee_id'],
							 :total_receipts => params['total_receipts'],
							 :total_contributions => params['total_contributions'],
							 :total_disbursements => params['total_disbursements'],
							 :end_cash => params['cash_on_hand'],
							 :date_coverage_from => params['date_coverage_from'],
							 :date_coverage_to => params['date_coverage_to'],
						   :total_refunds => params['total_refunds'],
						   :net_individual_contributions => params['net_individual_contributions'], 
						   :net_pac_contributions => params['net_pac_contributions'], 
               :net_party_contributions => params['net_party_contributions'], 
               :net_candidate_contributions => params['net_candidate_contributions'], 
               :net_primary_contributions => params['net_primary_contributions'], 
               :net_general_contributions => params['net_general_contributions'],
               :federal_funds => params['federal_funds'], 
               :contributions_less_than_200 => params['total_contributions_less_than_200'], 
               :contributions_200_499 => params['contributions_200_499'], 
               :contributions_500_1499 => params['contributions_500_1499'], 
               :contributions_1500_2499 => params['contributions_1500_2499'],
               :contributions_max => params['total_contributions_max']
		end
    
    # Returns an array of presidential candidates for a given cycle, defaults to the current cycle.
    # Only returns candidates that The New York Times is tracking for financial activity.
    def self.summary(cycle=CURRENT_CYCLE)
      reply = invoke("#{cycle}/president/totals", {})
      results = reply['results']
      results.map{|c| self.create_summary(c)}
    end
    
    # Returns a President object for a given presidential candidate in a given cycle, defaults to the current cycle.
    # Only returns candidates tracked by The New York Times.
    def self.detail(id, cycle=CURRENT_CYCLE)
      reply = invoke("#{cycle}/president/candidates/#{id}", {})
      results = reply['results'].first
      create_detail(results)
    end
    
    private
    
    def self.get_party party_identifier
       return "DEM" if party_identifier == "D"
       return "REP" if party_identifier == "R"
       party_identifier
    end
  end
end