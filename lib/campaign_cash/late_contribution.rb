module CampaignCash
  class LateContribution < Base

    attr_reader :contribution_date, :contributor_prefix, :contributor_zip, :contributor_suffix, :contributor_state, 
    :entity_type, :contributor_employer, :contributor_occupation, :fec_committee_id, :transaction_id, :contributor_last_name,
    :office_state, :contributor_fec_id, :contribution_amount, :contributor_street_1, :contributor_street_2, :contributor_city,
    :contributor_middle_name, :cycle, :fec_filing_id, :fec_candidate_id, :contributor_first_name, :contributor_organization_name
    
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
      results = invoke("#{cycle}/contributions/48hour", {:offset => offset})['results']
      results.map {|obj| create(obj)}
    end

    def self.candidate(candidate_id, offset = nil)
      cycle = CURRENT_CYCLE
      results = invoke("#{cycle}/candidates/#{candidate_id}/48hour", {:offset => offset})['results']
      results.map {|obj| create(obj)}
    end

    def self.committee(committee_id, offset = nil)
      cycle = CURRENT_CYCLE
      results = invoke("#{cycle}/committees/#{committee_id}/48hour", {:offset => offset})['results']
      results.map {|obj| create(obj)}
    end
  end
end
