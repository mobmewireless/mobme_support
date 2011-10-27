module MobME::Infrastructure::Utilities
  module MSISDN
    # In options, the key format can be one of 'local', 'country', 'plus_country', or 'international'.
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
  include MobME::Infrastructure::Utilities::MSISDN
end
