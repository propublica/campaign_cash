module CampaignCash
  class Filing < Base
    
    attr_reader :committee_name, :date_coverage_from, :amended_uri, :fec_uri, :date_coverage_to, :committee, :report_title, :amended
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
		def self.create_from_api(params={})
			self.new :committee_name => params['committee_name'],
							 :date_coverage_from => date_parser(params['date_coverage_from']),
							 :date_coverage_to => date_parser(params['date_coverage_to']),
							 :committee => params['committee'],
							 :report_title => params['report_title'],
							 :fec_uri => params['fec_uri'],
							 :amended => params['amended'],
							 :amended_uri => params['amended_uri']
		end
		
		def self.today
		  cycle = cycle_from_date
		  reply = Base.invoke("#{cycle}/filings", {})
		  results = reply['results']
			@filings = results.map{|c| Filing.create_from_api(c)}
		end
		
		def self.ymd(year, month, day)
		  cycle = cycle_from_date(Date.parse("#{month}/#{day}/#{year}"))
		  reply = Base.invoke("#{cycle}/filings/#{year}/#{month}/#{day}", {})
		  results = reply['results']
			@filings = results.map{|c| Filing.create_from_api(c)}
		end
		
  end
end