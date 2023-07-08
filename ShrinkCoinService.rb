require 'net/http'
require 'json'

class ShrinkCoinService
  def initialize(api_key)
    @api_key = api_key
  end

  def shrink_url(url, is_instant = true)
    api_url = 'https://shrinkco.in/api/shrink'
    parameters = {
      'API_KEY' => @api_key,
      'URL' => url,
      'IS_INSTANT' => is_instant.to_s
    }

    call_api(api_url, parameters)
  end

  def delete_url(id)
    api_url = 'https://shrinkco.in/api/delete'
    parameters = {
      'API_KEY' => @api_key,
      'ID' => id
    }

    call_api(api_url, parameters)
  end

  def check_url_clicks(id)
    api_url = 'https://shrinkco.in/api/clicks'
    parameters = {
      'API_KEY' => @api_key,
      'ID' => id
    }

    call_api(api_url, parameters)
  end

  def check_url_campaign_clicks(id, campaign)
    api_url = 'https://shrinkco.in/api/campaign'
    parameters = {
      'API_KEY' => @api_key,
      'ID' => id,
      'CAMPAIGN' => campaign
    }

    call_api(api_url, parameters)
  end

  private

  def call_api(url, parameters)
    uri = URI(url)
    uri.query = URI.encode_www_form(parameters)

    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
end
