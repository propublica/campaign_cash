module CampaignCash
  class IndependentExpenditure < Base
    
    attr_reader :fec_committee, :district, :state, :fec_committee_name, :purpose, :fec_candidate, :support_or_oppose, :date, :amount, :office, :amendment, :date_received, :payee, :fec_uri
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
    def self.create(params={})
      self.new :id => params['id'],
               :name => params['name']
    end
    
    def self.latest
      reply = Base.invoke("#{Base::CURRENT_CYCLE}/independent_expenditures")
      results = reply['results']
      @independent_expenditures = results.map{|c| IndependentExpenditure.create(c)}
    end
  end
end