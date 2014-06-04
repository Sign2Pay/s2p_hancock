module S2PHancock
  class Response
    attr_accessor :attributes
    attr_reader :body, :http_code

    ATTRIBUTE_MAP = {
      'confidence'      => 'confidence',
      'signature_id'    => 'signature_id',
      'verification_OK' => 'verification_OK'
    }

    def initialize(response = nil)
      raise ArgumentError, 'Missing response string' unless response
      @attributes = {}
      @body = response.body
      @http_code = response.code

      parse(response)
    end

    def parse(resp)
      if resp.success?
        parsed_response   = JSON.parse(resp.body)
        parsed_response.each do |k, v|
          if ATTRIBUTE_MAP.has_key?(k)
            set_attribute(ATTRIBUTE_MAP[k], v)
          else
            set_attribute(k.gsub(/([A-Z])/, '_\1').downcase, v)
          end
        end
      else
        handle_error(resp)
      end
      set_attribute(:success, resp.success?)
      set_attribute(:headers, resp.headers_hash)
      set_attribute(:total_time, resp.total_time)
    end

    def handle_error(response)
      if response.timed_out?
        # aw hell no
        set_attribute(:message, "timed_out")
      elsif response.code == 0
        # Could not get an http response, something's wrong.
        set_attribute(:message, response.return_message)
      else
        # Received a non-successful http response.
        set_attribute(:message, "HTTP request failed: " + response.code.to_s)
      end
    end

    # Returns an array of names for the attributes available
    # on this object sorted alphabetically.
    def attribute_names
      attributes.keys.sort
    end

    def method_missing(meth, *args)
      if meth.to_s[-1, 1] == '?'
        send(meth.to_s[0..-2])
      elsif attributes.has_key?(meth)
        attributes[meth]
      else
        super
      end
    end

    def respond_to?(meth)
      if meth.to_s[-1, 1] == '?'
        respond_to? meth[0..-2]
      else
        super
      end
    end

    protected

    def set_attribute(k, v)
      k = k.to_sym

      if v.nil?
        attributes[k] = nil
        return
      end

      v = Float(v) rescue v;

      case v
      when 'Yes', 'yes'
        attributes[k] = true
      when 'No', 'no'
        attributes[k] = false
      else
        attributes[k] = v
      end
    end
  end
end