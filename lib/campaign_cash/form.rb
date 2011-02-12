module CampaignCash
  class Form < Base
    
    def self.create(params={})
      self.new :id => params['id'],
               :name => params['name']
      
    end
    
    def self.form_types
      reply = Base.invoke("#{cycle}/filings/types")
      results = reply['results']
      @forms = results.map{|c| Form.create(c)}
    end
    
  end
end