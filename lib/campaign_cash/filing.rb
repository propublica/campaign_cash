module CampaignCash
  class Filing < Base
    
    attr_reader :committee_name, :date_coverage_from, :amended_uri, :fec_uri, :date_coverage_to, :committee, :report_title, :amended, :date_filed, :cycle, :form_type
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
		def self.create(params={})
			self.new :committee_name => params['committee_name'],
							 :date_coverage_from => date_parser(params['date_coverage_from']),
							 :date_coverage_to => date_parser(params['date_coverage_to']),
							 :committee => params['committee'],
							 :report_title => params['report_title'].strip,
							 :fec_uri => params['fec_uri'],
							 :amended => params['amended'],
							 :amended_uri => params['amended_uri'],
							 :form_type => params['form_type']
		end
		
		def self.create_from_filings(params={})
			self.new :date_coverage_from => date_parser(params['date_coverage_from']),
							 :date_coverage_to => date_parser(params['date_coverage_to']),
							 :report_title => params['report_title'].strip,
							 :fec_uri => params['fec_uri'],
							 :amended => params['amended'],
							 :amended_uri => params['amended_uri'],
							 :cycle => params['cycle'],
							 :form_type => params['form_type'],
							 :date_filed => date_parser(params['date_filed'])
		end
		
		
		def self.today
		  cycle=CURRENT_CYCLE
		  reply = Base.invoke("#{cycle}/filings", {})
		  results = reply['results']
			@filings = results.map{|c| Filing.create(c)}
		end
		
		def self.date(year, month, day)
		  cycle = cycle_from_date(Date.parse("#{month}/#{day}/#{year}"))
		  reply = Base.invoke("#{cycle}/filings/#{year}/#{month}/#{day}", {})
		  results = reply['results']
			@filings = results.map{|c| Filing.create(c)}
		end
		
		def self.by_type(cycle, form_type)
		  cycle = cycle
		  reply = Base.invoke("#{cycle}/filings/types/#{form_type}")
		  results = reply['results']
			@filings = results.map{|c| Filing.create(c)}
		end
	end
end