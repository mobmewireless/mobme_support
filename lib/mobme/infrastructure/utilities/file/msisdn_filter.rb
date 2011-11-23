require_relative '../version'
require_relative '../core_ext/hash/keys'
require 'active_support/core_ext/hash/reverse_merge'

module MobME::Infrastructure::Utilities::FileOperations
  # Filters input file for valid MSISDN-s.
  class MSISDNFilter
    class << self
      def filter(file_path, options_hash={})
        options_hash.recursively_symbolize_keys!
        options_hash.reverse_merge!({
          :country => "IN",
          :format => "local"
        })

        input_file_contents = get_file_contents(file_path)
        input_file_contents.scan(pattern(options_hash)).map do |e|
          case options_hash[:format]
            when "local"
              e[2]
            when "country"
              settings[options_hash[:country]]['country_code'] + e[2]
            when "plus_country"
              "+#{settings[options_hash[:country]]['country_code']}#{e[2]}"
            when "international"
              settings[options_hash[:country]]['international_prefix'] + settings[options_hash[:country]]['country_code'] + e[2]
            else
              raise "Invalid :format value - must be one of 'local', 'country', 'plus_country', or 'international'."
          end

        end
      end

      private

      def get_file_contents(file_path)
        input_file = File.open(file_path, 'r')
        input_file_contents = input_file.read
        input_file.close
        input_file_contents
      end

      def settings
        return @settings_hash unless @settings_hash.nil?

        settings_file = File.open(File.dirname(File.expand_path(__FILE__)) + "/../core_ext/string/msisdn_formats.yml", 'r')
        settings_hash = YAML.load(settings_file)
        settings_file.close
        @settings_hash = settings_hash
        settings_hash
      end

      def pattern(options_hash)
        settings[options_hash[:country]]['regexp']
      end
    end
  end
end