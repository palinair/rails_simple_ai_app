class Message < ApplicationRecord
  before_save :generate_response

  private

  def generate_response
    client = OpenAI::Client.new

    begin
      response = client.completions(
        parameters: {
          model: 'gpt-3.5-turbo-instruct', # O el modelo más reciente
          prompt: content,
          max_tokens: 150,
          temperature: 0.7
        }
      )
      self.response = response['choices'].first['text'].strip
    rescue => e
      self.response = 'Sorry, there was an error generating a response. Please try again later.'
      Rails.logger.error("OpenAI API Error: #{e.message}")
    end
  end
end
