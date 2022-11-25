require 'net/http'

module RestUtil

  def self.make_request(path, params = {})

    begin
      url = URI.parse("#{BASE_API_PATH}#{path}")
      url.query = URI.encode_www_form(params)

      Rails.logger.info "[GET] #{url}"
      req = Net::HTTP::Get.new(url.to_s)

      begin
        res = Net::HTTP.start(url.host) {|http|
          http.read_timeout = CONNECTION_TIMEOUT
          http.request(req)
        }
      rescue => ex
        Rails.logger.error ex.message
      else
        if res.code == '200'
          res.body.present? ? JSON.parse(res.body) : nil
        else
          Rails.logger.error "#{res.code} - #{res.message}"
          nil
        end
      end
    end
  end

end
