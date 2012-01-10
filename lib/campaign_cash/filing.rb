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
							 :committee => parse_committee(params['committee']),
							 :report_title => params['report_title'].strip,
							 :fec_uri => params['fec_uri'],
							 :amended => params['amended'],
							 :amended_uri => params['amended_uri'],
							 :original_filing => params['original_filing'],
							 :original_uri => params['original_uri'],
							 :paper => params['paper'],
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
		
		
		def self.today(offset=0)
		  cycle=CURRENT_CYCLE
		  reply = Base.invoke("#{cycle}/filings", {:offset => offset})
		  results = reply['results']
			results.map{|c| Filing.create(c)}
		end
		
		def self.date(year, month, day, offset=0)
		  cycle = cycle_from_date(Date.strptime("#{month}/#{day}/#{year}", '%m/%d/%Y'))
		  reply = Base.invoke("#{cycle}/filings/#{year}/#{month}/#{day}", {:offset => offset})
		  results = reply['results']
			results.map{|c| Filing.create(c)}
		end
		
		def self.by_type(cycle, form_type)
		  cycle = cycle
		  reply = Base.invoke("#{cycle}/filings/types/#{form_type}")
		  results = reply['results']
			results.map{|c| Filing.create(c)}
		end
	end
end