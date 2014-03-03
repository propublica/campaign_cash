module CampaignCash
  class Committee < Base

    FILING_FREQUENCY = {
      A: 'Administratively Terminated',
      D: 'Debt',
      M: 'Monthly',
      Q: 'Quarterly',
      T: 'Terminated',
      W: 'Waived'
    }

    INTEREST_GROUP = {
      C: 'Corporation',
      L: 'Labor Union',
      M: 'Membership',
      T: 'Trade Association',
      V: 'Cooperative',
      W: 'Corporation without Capital Stock'
    }

    COMMITTEE_TYPE = {
      C: 'Communication Cost',
      D: 'Delegate',
      E: 'Electioneering Communications',
      H: 'House Candidate',
      I: 'Independent Expenditure (Person or Group)',
      N: 'Non-Party, Non-Qualified',
      P: 'Presidential Candidate',
      Q: 'Qualified Non-Party',
      S: 'Senate Candidate',
      X: 'Non-Qualified Party',
      Y: 'Qualified Party',
      Z: 'National Party Non-Federal'
    }

    COMMITTEE_DESIGNATION = {
      A: 'Authorized by a Candidate',
      J: 'Joint Fundraiser',
      P: 'Principal Campaign Committee',
      U: 'Unauthorized',
      B: 'Lobbyist/Registrant PAC',
      D: 'Leadership PAC'
    }

    attr_reader :name, :id, :state, :district, :party, :fec_uri, :candidate, 
    :city, :address, :state, :zip, :relative_uri, :sponsor_name,
    :total_receipts, :total_contributions, :total_from_individuals, 
    :total_from_pacs, :candidate_loans, :total_disbursements,
    :total_refunds, :debts_owed, :begin_cash, :end_cash,
    :date_coverage_to, :date_coverage_from, :other_cycles, :super_pac, :filings,
    :total_candidate_contributions, :total_independent_expenditures

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    def self.create(params={})
      self.new name: params['name'],
      id: params['id'],
      state: params['state'],
      party: params['party'],
      fec_uri: params['fec_uri'],
      city: params['city'],
      address: params['address'],
      zip: params['zip'],
      sponsor_name: params['sponsor_name'],
      leadership: params['leadership'],
      super_pac: params['super_pac'],
      total_receipts: params['total_receipts'].to_f,
      total_contributions: params['total_contributions'].to_f,
      total_from_individuals: params['total_from_individuals'].to_f,
      total_from_pacs: params['total_from_pacs'].to_f,
      candidate_loans: params['candidate_loans'].to_f,
      total_disbursements: params['total_disbursements'].to_f,
      total_candidate_contributions: params['total_candidate_contributions'].to_f,
      total_independent_expenditures: params['total_independent_expenditures'].to_f,
      total_refunds: params['total_refunds'].to_f,
      debts_owed: params['debts_owed'].to_f,
      begin_cash: params['begin_cash'].to_f,
      end_cash: params['end_cash'].to_f,
      date_coverage_from: date_parser(params['date_coverage_from']),
      date_coverage_to: date_parser(params['date_coverage_to']),
      candidate_id: parse_candidate(params['candidate']),
      filing_frequency: get_frequency(params['filing_frequency']),
      interest_group: get_interest_group(params['interest_group']),
      committee_type: get_committee_type(params['committee_type']),
      designation: get_designation(params['designation']),
      other_cycles: params['other_cycles'].map{|cycle| cycle['cycle']['cycle']}
    end

    def self.create_from_search_results(params={})
      self.new name: params['name'],
      id: params['id'],
      city: params['city'],
      state: params['state'],
      zip: params['zip'],
      district: params['district'],
      party: params['party'],
      candidate_id: parse_candidate(params['candidate']),
      treasurer: params['treasurer'],
      fec_uri: params['fec_uri'],
      leadership: params['leadership'],
      super_pac: params['super_pac']
    end

    def self.get_frequency(frequency)
      if frequency
        FILING_FREQUENCY[frequency.strip] unless frequency.empty?
      end
    end

    def self.get_interest_group(interest_group)
      if interest_group
        INTEREST_GROUP[interest_group.strip] unless interest_group.empty?
      end
    end

    def self.get_committee_type(committee_type)
      if committee_type
        COMMITTEE_TYPE[committee_type.strip] unless committee_type.empty?
      end
    end

    def self.get_designation(designation)
      if designation
        COMMITTEE_DESIGNATION[designation.strip] unless designation.empty?
      end
    end

    def self.find(fecid, cycle=CURRENT_CYCLE)
      reply = invoke("#{cycle}/committees/#{fecid}")
        result = reply['results']
      create(result.first) if result.first
    end

    def self.search(name, cycle=CURRENT_CYCLE, offset=nil)
      reply = invoke("#{cycle}/committees/search", {query: name, offset: offset})
      results = reply['results']      
      results.map{|c| create_from_search_results(c)}
    end

    def self.latest(cycle=CURRENT_CYCLE)
      reply = invoke("#{cycle}/committees/new",{})
      results = reply['results']      
      results.map{|c| create_from_search_results(c)}      
    end

    def self.superpacs(cycle=CURRENT_CYCLE, offset=nil)
      reply = invoke("#{cycle}/committees/superpacs",{offset: offset})
      results = reply['results']      
      results.map{|c| create_from_search_results(c)}
    end

    def filings(cycle=CURRENT_CYCLE, offset=nil)
      reply = Base.invoke("#{cycle}/committees/#{id}/filings",{offset: offset})
        results = reply['results']
      results.map{|c| Filing.create(c)}
    end

    def unamended_filings(cycle=CURRENT_CYCLE, offset=nil)
      reply = Base.invoke("#{cycle}/committees/#{id}/filings",{offset: offset})
        results = reply['results'].select{|f| f['amended'] == false}
      results.map{|c| Filing.create(c, name=self.name)}
    end

  end
end
