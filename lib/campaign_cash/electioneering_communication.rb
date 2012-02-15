module CampaignCash
  class ElectioneeringCommunication < Base
    attr_reader :payee_zip, :committee_name, :entity_type, :filing_id, :payee_organization, :electioneering_communication_candidates, :amount, :fec_committee_id, :payee_city, :transaction_id, :amended_from, :communication_date, :payee_first_name, :payee_state, :back_reference_tran_id_number, :expenditure_date, :cycle, :payee_address_1, :back_reference_sched_name, :payee_address_2, :payee_last_name, :election_code, :payee_middle_name, :payee_suffix, :purpose, :unique_id, :filed_date

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    def self.create(params={})
      self.new(params)
    end

    def self.latest(offset = nil)
      cycle = CURRENT_CYCLE
      results = invoke("#{cycle}/electioneering_communications", {:offset => offset})['results']
      results.map {|obj| ElectioneeringCommunication.create(obj["electioneering_communication"])}
    end
    
    def self.committee(committee_id, offset = nil)
      cycle = CURRENT_CYCLE
      results = invoke("#{cycle}/committees/#{committee_id}/electioneering_communications", {:offset => offset})['results']
      results.map {|obj| ElectioneeringCommunication.create(obj["electioneering_communication"])}
    end

    def self.date(date, offset = nil)
      cycle = CURRENT_CYCLE
      d     = Date.strptime(date, '%m/%d/%Y')
      results = invoke("#{cycle}/electioneering_communications/#{d.year}/#{d.month}/#{d.day}", {:offset => offset})['results']
      results.map {|obj| ElectioneeringCommunication.create(obj["electioneering_communication"])}
    end
  end
end