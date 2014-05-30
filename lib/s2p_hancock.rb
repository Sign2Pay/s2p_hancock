require 'typhoeus'
require 'json'

require "s2p_hancock/version"
require "s2p_hancock/request"
require "s2p_hancock/response"

module S2PHancock

  class << self
    attr_accessor :license_key
    attr_accessor :endpoint
  end

end
