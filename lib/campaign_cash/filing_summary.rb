module CampaignCash
  class FilingSummary < Base
    
    attr_reader :pac_contributions_period, :contributions_2500, :party_contributions_cycle, :fundraising_offsets_period, :primary_general, :pac_refunds_cycle, :party_refunds_cycle, :fundraising_expenses_period, :net_party_contributions, :num_contributions_200_499, :individual_refunds_cycle, :candidate_contributions_period, :legal_offsets_cycle, :num_contributions_500_1499, :net_operating_expenses, :total_debts_owed, :refunds_200_499, :refunds_1500_2499, :transfers_out_period, :net_primary, :liquidate_period, :contributions_200_499, :operating_offsets_cycle, :num_contributions_1500_2499, :candidate_loan_repayments_period, :committee_uri, :federal_funds_cycle, :net_candidate_contributions, :candidate_loans_period, :filing_id, :net_pac_contributions, :num_refunds_200_499, :candidate_loan_repayments_cycle, :total_offsets_cycle, :party_contributions_period, :net_individual_contributions, :num_refunds_1500_2499, :net_general, :total_receipts_cycle, :federal_funds_period, :transfers_out_cycle, :cycle, :other_loan_repayments_period, :contributions_500_1499, :legal_offsets_period, :date_coverage_from, :contributions_less_than_200, :fec_form_type, :candidate_contributions_cycle, :cash_on_hand_beginning, :individual_refunds_period, :fundraising_expenses_cycle, :num_refunds_500_1499, :cash_on_hand_close, :num_contributions_less_than_200, :total_loans_cycle, :candidate_uri, :contributions_1500_2499, :refunds_2500, :flag_most_current_report, :total_loan_repayments_period, :other_loans_period, :operating_expenditures_cycle, :other_disbursements_period, :total_loans_period, :transfers_in_period, :transfers_in_cycle, :report, :legal_expenses_period, :candidate_loans_cycle, :individual_contributions_period, :other_disbursements_cycle, :total_disbursements_period, :other_loans_cycle, :net_transfers_in, :net_disbursements, :operating_expenditures_period, :fundraising_offsets_cycle, :date_coverage_to, :total_loan_repayments_cycle, :total_disbursements_cycle, :party_refunds_period, :individual_contributions_cycle, :net_total_contributions, :other_loan_repayments_cycle, :total_refunds_cycle, :total_receipts_period, :total_offsets_period, :total_contributions_period, :total_contributions_cycle, :refunds_500_1499, :pac_refunds_period, :flag_valid_report, :legal_expenses_cycle, :num_refunds_less_than_200, :refunds_less_than_200, :pac_contributions_cycle, :net_legal_expenses, :net_fundraising_expenses, :num_contributions_2500, :total_refunds_period, :operating_offsets_period, :num_refunds_2500
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
		def self.create(params={})
			self.new(params)
		end
		
		def self.by_id(id)
      cycle = CURRENT_CYCLE
      result = FilingSummary.create(Base.invoke("#{cycle}/filings/#{id}")["results"]["filing_summary"])
    end
  end
end


