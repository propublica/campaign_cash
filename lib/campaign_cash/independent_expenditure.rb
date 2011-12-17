module CampaignCash
  class IndependentExpenditure < Base
    
    attr_reader :fec_committee_id, :district, :state, :fec_committee_name, :purpose, :fec_candidate_id, :support_or_oppose, :date, :amount, :office, :amendment, :date_received, :payee, :fec_uri
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
    def self.create(params={})
      self.new :fec_committee_id => params['fec_committee'].split('/').last.split('.').first,
               :fec_committee_name => params['fec_committee_name'],
               :fec_candidate_id => params['fec_candidate'].split('/').last.split('.').first,
               :office => params['office'],
               :state => params['state'].strip,
               :district => params['district'],
               :date => date_parser(params['date']),
               :support_or_oppose => params['support_or_oppose'],
               :payee => params['payee'],
               :purpose => params['purpose'],
               :amount => params['amount'],
               :fec_uri => params['fec_uri'],
               :date_received => date_parser(params['date_received'])
    end
    
    def self.latest
      reply = Base.invoke("#{Base::CURRENT_CYCLE}/independent_expenditures")
      results = reply['results']
      @independent_expenditures = results.map{|c| IndependentExpenditure.create(c)}
    end
    
    def self.date(date)
      d = Date.parse(date)
      cycle = cycle_from_date(d)
      reply = Base.invoke("#{cycle}/independent_expenditures/#{d.year}/#{d.month}/#{d.day}")
      results = reply['results']
      @independent_expenditures = results.map{|c| IndependentExpenditure.create(c)}      
    end
    
    def self.committee(id, cycle)
      @independent_expenditures = []
      reply = Base.invoke("#{cycle}/committees/#{id}/independent_expenditures")
      results = reply['results']
      comm = reply['fec_committee']
      results.each do |result|
        result['fec_committee'] = comm
        @independent_expenditures << IndependentExpenditure.create(result)
      end
      @independent_expenditures
    end
    
    def self.candidate(id, cycle)
      @independent_expenditures = []
      reply = Base.invoke("#{cycle}/candidates/#{id}/independent_expenditures")
      results = reply['results']
      cand = reply['fec_candidate']
      results.each do |result|
        result['fec_candidate'] = cand
        @independent_expenditures << IndependentExpenditure.create(result)
      end
      @independent_expenditures
    end
    
    def self.president(cycle=Base::CURRENT_CYCLE)
      reply = Base.invoke("#{cycle}/president/independent_expenditures")
      results = reply['results']
      @independent_expenditures = results.map{|c| IndependentExpenditure.create(c)}
    end
    
  end
end