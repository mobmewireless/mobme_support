module MobME::Infrastructure::Utilities::CoreExtensions
  module MSISDN
    # Validates and converts an MSISDN in the string to the required format
    # @param [Hash] options_hash Options to pass into the function
    # @option options_hash [String] :country The country code for the MSISDN
    # @option options_hash [String] :format Either 'local', 'international', 'country', 'plus_country'
    # @example Convert to an international format
    #   "9846819033".msisdn(:country => "IN", :format => 'international')
    #   "00919846819033"
    # @example Convert to a 10 digit mobile number
    #   "+919846819033".msisdn(:format => 'local')
    #   "9846819033"
    def msisdn(options_hash = {})
      default_options = {
        :country => 'IN',
        :format => 'local'
      }

      options_hash = options_hash.symbolize_keys.reverse_merge(default_options)

      msisdn_format = YAML.load_file(File.dirname(__FILE__) + "/msisdn_formats.yml")[options_hash[:country]]

      msisdn = self.strip
      if msisdn.match(msisdn_format['regexp'])
        local_segment = msisdn[-(msisdn_format['local_digits'])..-1]
        case options_hash[:format]
          when 'local'
            local_segment
          when 'country'
            "#{msisdn_format['country_code']}#{local_segment}"
          when 'plus_country'
            "+#{msisdn_format['country_code']}#{local_segment}"
          when "international"
            "#{msisdn_format['international_prefix']}#{msisdn_format['country_code']}#{local_segment}"
        end
      else
        nil
      end
    end

    def msisdn?(options_hash = {})
      msisdn(options_hash) ? true : false
    end
  end
end

class String
  include MobME::Infrastructure::Utilities::CoreExtensions::MSISDN
end
