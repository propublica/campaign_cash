module CampaignCash
  class Contribution < Base
    
    attr_reader :date, :candidate_uri, :primary_general, :amount, :state, :name, :image_uri, :party, :district, :committee_uri, :results, :total_results, :total_amount, :cycle
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
		def self.create(params={})
		  self.new :committee_uri => params['committee'],
		           :total_results => params['total_results'],
		           :cycle => params['cycle'],
		           :total_amount => params['total_amount'],
		           :results => params['results'].map{|c| OpenStruct.new({
               :date => date_parser(c['date']),
		           :candidate_uri => c['candidate_uri'],
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
			else
			  reply = invoke("#{cycle}/committees/#{fecid}/contributions")
			end
			create(reply)
    end
		
  end
end