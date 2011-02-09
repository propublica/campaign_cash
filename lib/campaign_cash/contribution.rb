module CampaignCash
  class Contribution < Base
    
    attr_reader :date, :candidate_uri, :primary_general, :amount, :state, :name, :image_uri, :party, :district
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
		def self.create_from_api(params={})
		  self.new :date => date_parser(params[:date]),
		           :candidate_uri => params[:candidate_uri],
		           :primary_general => params[:primary_general],
		           :amount => params[:amount],
		           :state => params[:state],
		           :name => params[:name],
		           :image_uri => params[:image_uri],
		           :party => params[:party],
		           :district => params[:district]
		end
  end
end