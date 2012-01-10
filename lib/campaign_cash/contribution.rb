module CampaignCash
  class Contribution < Base
    
    attr_reader :date, :candidate_uri, :primary_general, :amount, :state, :name, :image_uri, :party, :district, :committee_uri, :results, :total_results, :total_amount, :cycle
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
    def self.to_candidate(params={})
      self.new :committee => parse_committee(params['committee']),
               :cycle => params['cycle'],
               :total_amount => params['total_amount'],
               :results => params['results'].map{|c| OpenStruct.new({
               :candidate => parse_candidate(params['candidate_uri']),
               :date => date_parser(c['date']),
               :primary_general => c['primary_general'],
               :amount => c['amount'],
               :state => c['state'],
               :name => c['name'],
               :image_uri => c['image_uri'],
               :party => c['party'],
               :district => c['district']})}
               
    end
    
    def self.all_candidates(params={})
      self.new :committee => parse_committee(params['committee']),
               :cycle => params['cycle'],
               :total_amount => params['total_amount'],
               :total_results => params['total_results'],
               :results => params['results'].map{|c| OpenStruct.new({
               :date => date_parser(c['date']),
               :candidate => parse_candidate(c['candidate_uri']),
               :primary_general => c['primary_general'],
               :amount => c['amount'],
               :state => c['state'],
               :name => c['name'],
               :image_uri => c['image_uri'],
               :party => c['party'],
               :district => c['district']})}
               
    end
    
    def self.find(fecid, cycle=CURRENT_CYCLE, candidate=nil)
      if candidate
        reply = invoke("#{cycle}/committees/#{fecid}/contributions/candidates/#{candidate}")
        to_candidate(reply)
      else
        reply = invoke("#{cycle}/committees/#{fecid}/contributions")
        all_candidates(reply)
      end
    end
    
  end
end