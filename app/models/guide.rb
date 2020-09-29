require 'faraday'
API_URL = "http://cms.golfsnack.se"

class Guide

  def self.latest
    resp = Faraday.get "#{API_URL}/guides"
    JSON.parse(resp.body)
  end

  def self.by_id(id)
    resp = Faraday.get "#{API_URL}/guides/#{id}"
    JSON.parse(resp.body)
  end

end
