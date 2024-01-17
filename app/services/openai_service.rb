class OpenaiService
  include HTTParty
  BASE_URL = 'https://api.openai.com/v1/chat/completions'.freeze

  def initialize(query)
    @query = query
  end

  def call
    response = HTTParty.post(BASE_URL, body: request_body.to_json, headers: headers, timeout: 500)
    raise response_error(response) unless response.code == 200

    response['choices'][0]['message']['content']
  end

  private

  def request_body
    {
      model: 'gpt-3.5-turbo',
      messages: [{ role: 'user', content: @query }]
    }
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{Rails.application.credentials.openai_api_key}"
    }
  end

  def response_error(response)
    "OpenAI API Error: #{response['error']['message']}"
  end
end
