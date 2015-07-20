

module Imgur

  class Client
  include HTTParty

    def initialize
      # @auth = ENV['IMGURKEY']
    end

    headers 'Authorization' => "client_id #{ENV['IMGURKEY']}"

    def upload_photo(base64)
      response = self.class.post("https://api.imgur.com/3/image/#{base64}")
    end

  end

end
