require 'httparty'

class IdealistaScraperService
  include HTTParty
  base_uri 'https://api.apify.com/v2'

  def initialize
    @api_token = Rails.application.config_for(:apify)['api_token']
  end

  def run_scraper(params = {})
    query = {
      token: @api_token,
      # Add any additional query parameters required by the APIFY API
    }.merge(params)

    response = self.class.post('/acts/your_act_id/runs', query: query)
    # Handle the response and return the relevant data
    # You can parse the JSON response and extract the desired information
    # For example:
    # JSON.parse(response.body)
  end
end
