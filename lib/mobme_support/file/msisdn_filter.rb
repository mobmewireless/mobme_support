require_relative '../version'
require_relative '../core_ext/string/msisdn'

require 'active_support/core_ext/hash/reverse_merge'

module MobmeSupport::FileOperations
  # Filters for MSISDN-s in files.
  class MSISDNFilter
    class << self

      # Filters input file for valid MSISDN-s.
      #
      # @param [String] file_path Path to file containing line-separated MSISDN-s.
      # @param [Hash] options_hash Options with which to evaluate MSISDN-s.
      # @option options_hash [String] :country ('IN') The ISO 3166 code for the MSISDN's country.
      # @option options_hash [String] :format ('local') Either 'local', 'international', 'country', 'plus_country'.
      # @return [Array] Array of valid MSISDN-s in requested format.
      # @example MSISDN filtration on a file.
      #   MobmeSupport::FileOperations::MSISDNFilter.filter('/absolute/path/to/file')
      #   >> ['9876543210', '9876543211', '9876543212', ... ]
      #   MobmeSupport::FileOperations::MSISDNFilter.filter('/absolute/path/to/file', format: 'plus_country')
      #   >> ['+919876543210', '+919876543211', '+919876543212', ... ]
      def filter(file_path, options_hash={})
        options_hash = options_hash.with_indifferent_access.reverse_merge(
          country: 'IN',
          format: 'local'
        )

        input_file_contents = get_file_contents(file_path)

        input_file_contents.inject([]) do |result, element|
          result << element.msisdn(options_hash)
          result
        end - [nil]
      end

      private

      # Retrieves contents of a file at specified path.
      def get_file_contents(file_path)
        input_file = File.open(file_path, 'r')
        input_file_contents = input_file.read
        input_file.close
        input_file_contents.split("\n")
      end
    end
  end
end