require 'test_helper'

class TestCampaignCash::TestForm < Minitest::Test
	include CampaignCash
		
	context "form types" do
	  setup do
			@forms = Form.form_types
	  end
	  
		should "return a list of objects of the Filing type" do
			assert_kind_of(Form, @forms.first)
		end
	end
end