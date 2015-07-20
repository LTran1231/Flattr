
module Imgur

  class Client
    include HTTParty
    base_uri 'https://api.imgur.com/3'

    def initialize(base64)
      @options = { query: {image: base64}}
    end
    # headers 'Authorization' => "client_id #{ENV['IMGURKEY']}"

    def upload_photo
      self.class.post("/image", @options)
    end

  end

end
