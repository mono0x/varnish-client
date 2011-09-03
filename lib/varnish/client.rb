
require 'net/http'

module Varnish
  class Client
    def initialize(host, port, target)
      @http   = Net::HTTP.new(host, port)
      @target = URI.parse(target.to_s)
    end

    def purge(cmd)
      req = Purge.new(cmd)
      req['Host'] = @target.host
      res = @http.request(req)
      res.code == '200'
    end

    def fetch(path, headers = {})
      req = Net::HTTP::Get.new(path)
      req['Host'] = @target.host
      res = @http.request(req)
      return nil unless res.code == '200'
      res.body
    end

    private

    class Purge < Net::HTTPRequest
      METHOD            = 'PURGE'
      REQUEST_HAS_BODY  = false
      RESPONSE_HAS_BODY = true
    end
  end
end

