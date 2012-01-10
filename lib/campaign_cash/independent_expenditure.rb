module CampaignCash
  class IndependentExpenditure < Base
    
    attr_reader :fec_committee_id, :district, :state, :fec_committee_name, :purpose, :fec_candidate_id, :support_or_oppose, :date, :amount, :office, :amendment, :date_received, :payee, :fec_uri
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
    def self.create(params={})
      self.new :committee => parse_committee(params['fec_committee']),
               :committee_name => params['fec_committee_name'],
               :candidate => parse_candidate(params['fec_candidate']),
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
    
    def self.latest(offset=0)
      reply = Base.invoke("#{Base::CURRENT_CYCLE}/independent_expenditures",{:offset => offset})
      results = reply['results']
      results.map{|c| IndependentExpenditure.create(c)}
    end
    
    def self.date(date,offset=0)
      d = Date.strptime(date, '%m/%d/%Y')
      cycle = cycle_from_date(d)
      reply = Base.invoke("#{cycle}/independent_expenditures/#{d.year}/#{d.month}/#{d.day}",{:offset => offset})
      results = reply['results']
      results.map{|c| IndependentExpenditure.create(c)}      
    end
    
    def self.committee(id, cycle, offset=0)
      independent_expenditures = []
      reply = Base.invoke("#{cycle}/committees/#{id}/independent_expenditures",{:offset => offset})
      results = reply['results']
      comm = reply['fec_committee']
      results.each do |result|
        result['fec_committee'] = comm
        independent_expenditures << IndependentExpenditure.create(result)
      end
      independent_expenditures
    end
    
    def self.candidate(id, cycle, offset=0)
      independent_expenditures = []
      reply = Base.invoke("#{cycle}/candidates/#{id}/independent_expenditures",{:offset => offset})
      results = reply['results']
      cand = reply['fec_candidate']
      results.each do |result|
        result['fec_candidate'] = cand
        independent_expenditures << IndependentExpenditure.create(result)
      end
      independent_expenditures
    end
    
    def self.president(cycle=Base::CURRENT_CYCLE,offset=0)
      reply = Base.invoke("#{cycle}/president/independent_expenditures",{:offset => offset})
      results = reply['results']
      results.map{|c| IndependentExpenditure.create(c)}
    end
    
  end
end