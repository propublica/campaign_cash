module CampaignCash
  class Form < Base
    
    attr_reader :id, :name
    
    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
    
    def self.create(params={})
      self.new :id => params['id'],
               :name => params['name']
    end
    
    def self.form_types
      reply = Base.invoke("#{Base::CURRENT_CYCLE}/filings/types")
      results = reply['results']
      @forms = results.map{|c| Form.create(c)}
    end
    
  end
end