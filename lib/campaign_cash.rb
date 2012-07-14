%w(base candidate committee contribution individual_contribution filing filing_summary form independent_expenditure president electioneering_communication late_contribution).each do |f|
  require File.join(File.dirname(__FILE__), '../lib/campaign_cash', f)
end