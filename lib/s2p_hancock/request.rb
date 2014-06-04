module S2PHancock
  class Request

    DefaultTimeout = 6000

    class << self
      attr_accessor :timeout
    end

    # Required Fields
    attr_accessor :signature_id

    def initialize(attrs={})
      self.attributes = attrs
    end

    def attributes=(attrs={})
      attrs.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def process!
      resp = get(query)
      resp.body.encode!("utf-8", "iso-8859-1") if resp.body && resp.body.respond_to?(:encode!)
      S2PHancock::Response.new(resp)
    end

    def process
      process!
    rescue Exception => e
      p e
      false
    end

    def query
      validate

      required_fields = {
        :signature_id     => @signature_id,
        :license_key      => S2PHancock::license_key
      }

    end

    private

    # Returns an HTTPResponse object
    def get(query_params)
      request = Typhoeus::Request.new(
        "#{S2PHancock::endpoint}/#{query_params[:signature_id]}",
        :timeout  =>  self.class.timeout || DefaultTimeout,
        :method   => :get,
        :headers  => { "S2P_License" => S2PHancock::license_key.to_s }
      )
      resp = request.run
    rescue Exception => e
      raise e
    end

    protected
    def validate
      raise ArgumentError, 'License key is required' unless S2PHancock::license_key
      raise ArgumentError, 'Endpoint key is required' unless S2PHancock::endpoint
      raise ArgumentError, 'Signature ID is required' unless signature_id

    end
  end
end