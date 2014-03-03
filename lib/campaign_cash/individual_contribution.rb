module CampaignCash
  class IndividualContribution < Base

    attr_reader :zip5, :system_code, :occupation, :conduit_zip, :conduit_address_two, :city, :zip, :increased_limit, :donor_candidate, :conduit_name, :conduit_city, :prefix, :memo_text, :back_ref_tran_id, :aggregate_amount, :filing_id, :donor_office, :back_ref_sched_name, :address_two, :pac_name, :exclude, :conduit_address_one, :amount, :transaction_type, :lng, :flag_orgind, :date, :fec_form_type, :donor_state, :donor_cand_id, :last_name, :full_name, :employer, :donor_district, :conduit_state, :address_one, :tran_id, :suffix, :donor_cmte_id, :display_name, :transaction_description, :prigen, :memo_code, :linenumber, :lat, :amended_cd, :state, :middle_name, :first_name

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    def self.create(params={})
      self.new(params)
    end

    def self.committee(fecid, offset=nil)
      cycle = CURRENT_CYCLE
      results = invoke("#{cycle}/contributions/committee/#{fecid}", {offset: offset})['results']
        results.map{|c| IndividualContribution.create(c) }
    end

    def self.filing(form_id, offset=nil)
      cycle = CURRENT_CYCLE
      results = invoke("#{cycle}/contributions/filing/#{form_id}", {offset: offset})['results']
        results.map{|c| IndividualContribution.create(c) }
    end
  end
end
