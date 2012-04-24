require 'rubygems'
require 'open-uri'
require 'json'
require 'date'
require 'ostruct'

module CampaignCash
  class Base
    API_SERVER = 'api.nytimes.com'
    API_VERSION = 'v3'
    API_NAME = 'elections/us'
    API_BASE = "/svc/#{API_NAME}/#{API_VERSION}/finances"
    CURRENT_CYCLE = 2012

    @@api_key = nil
    @@copyright = nil

    class << self

      ##
      # The copyright footer to be placed at the bottom of any data from the New York Times. Note this is only set after an API call.
      def copyright
        @@copyright
      end

      def cycle
        @@cycle
      end

      def base_uri
        @@base_uri
      end

      ##
      # Set the API key used for operations. This needs to be called before any requests against the API. To obtain an API key, go to http://developer.nytimes.com/
      def api_key=(key)
        @@api_key = key
      end

      def api_key
        @@api_key
      end

      def date_parser(date)
        date ? Date.strptime(date, '%Y-%m-%d') : nil
      end

      def parse_candidate(candidate)
        return nil if candidate.nil?
        candidate.split('/').last.split('.').first
      end

      def parse_committee(committee)
        return nil if committee.nil?
        committee.split('/').last.split('.').first
      end

      # Returns the election cycle (even-numbered) from a date.
      def cycle_from_date(date=Date.today)
        date.year.even? ? date.year : date.year+1
      end

      def check_offset(offset)
        raise "Offset must be a multiple of 20" if offset % 20 != 0
      end

      ##
      # Builds a request URI to call the API server
      def build_request_url(path, params)
        URI::HTTP.build :host => API_SERVER,
          :path => "#{API_BASE}/#{path}.json",
        :query => params.map {|k,v| "#{k}=#{v}"}.join('&')
      end

      def invoke(path, params={})
        begin
          if @@api_key.nil?
            raise "You must initialize the API key before you run any API queries"
          end

          full_params = params.merge 'api-key' => @@api_key
          full_params.delete_if {|k,v| v.nil?}

          check_offset(params[:offset]) if params[:offset]

          uri = build_request_url(path, full_params)

          reply = uri.read
          parsed_reply = JSON.parse reply

          if parsed_reply.nil?
            raise "Empty reply returned from API"
          end

          @@copyright = parsed_reply['copyright']
          @@cycle = parsed_reply['cycle']
          @@base_uri = parsed_reply['base_uri']

          parsed_reply
        rescue OpenURI::HTTPError => e
          if e.message =~ /^404/
            return nil
          end

          raise "Error connecting to URL #{uri} #{e}"
        end
      end
    end
  end
end
