# Standard
require 'yaml'

# Gems
require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/reverse_merge'
require 'active_support/core_ext/hash/indifferent_access'

# Local
require_relative '../../version'

module MobmeSupport::CoreExtensions
  # String extension, which allows MSISDN validation.
  module MSISDN

    # Validates and converts an MSISDN in the string to the required format.
    #
    # @param [Hash] options_hash Options to pass into the function
    # @option options_hash [String] :country ('IN') The ISO 3166 code for the MSISDN's country.
    # @option options_hash [String] :format ('local') Either 'local', 'international', 'country', 'plus_country'.
    # @return [String, nil] Validated MSISDN, or nil.
    # @example Convert to an international format.
    #   "31234567".msisdn(:country => "BH", :format => 'international')
    #   "0097331234567"
    # @example Convert to a 10 digit mobile number.
    #   "+919846819033".msisdn(:format => 'local')
    #   "9846819033"
    def msisdn(options_hash = {})
      options_hash = options_hash.with_indifferent_access.reverse_merge(
        country: 'IN',
        format: 'local'
      )

      @@msdn_format_data ||= YAML.load_file(File.dirname(__FILE__) + '/msisdn_formats.yml')
      msisdn_format = @@msdn_format_data[options_hash[:country]]
      msisdn = self.strip
      match_data = msisdn.match msisdn_format['regexp']

      if match_data
        local_segment = match_data[:local]

        case options_hash[:format]
          when 'local'
            local_segment
          when 'country'
            "#{msisdn_format['country_code']}#{local_segment}"
          when 'plus_country'
            "+#{msisdn_format['country_code']}#{local_segment}"
          when 'international'
            "#{msisdn_format['international_prefix']}#{msisdn_format['country_code']}#{local_segment}"
          else
            raise "Invalid :format value - must be one of 'local', 'country', 'plus_country', or 'international'."
        end
      else
        nil
      end
    end

    # Validates an MSISDN.
    #
    # @param [Hash] options_hash Options to pass into the function.
    # @option options_hash [String] :country ('IN') The ISO 3166 code for the MSISDN's country.
    # @return [Boolean] True if string is a valid MSISDN. False, otherwise.
    # @example Validate an Indian MSISDN.
    #   "9846819033".msisdn?
    #   true
    # @example Validate an non-Indian MSISDN.
    #   "+919846819033".msisdn?(:country => 'CA')
    #   false
    def msisdn?(options_hash = {})
      default_options = {
          :country => 'IN',
          :format => 'local'
      }
      options_hash = options_hash.symbolize_keys.reverse_merge(default_options)
      @@msdn_format_data ||= YAML.load_file(File.dirname(__FILE__) + '/msisdn_formats.yml')
      msisdn_format = @@msdn_format_data[options_hash[:country]]
     return false unless self =~ msisdn_format['regexp']
      true
    end
  end
end

class String
  include MobmeSupport::CoreExtensions::MSISDN
end
