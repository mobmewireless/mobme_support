# Gems
require 'active_support/core_ext/hash/keys'

# Local
require_relative '../../version'

module MobmeSupport::CoreExtensions
  # Hash extension, allowing recursive Hash key symbolization
  module Keys
    # Returns a version of the supplies Hash or Array with all Hash keys symbolized.
    #
    # @param [Boolean] modify_nested_arrays set to true to iterate over array contents. Defaults to false.
    # @return [Hash, Array] recursively symbolized Array or Hash
    def recursively_symbolize_keys(modify_nested_arrays = false)
      case self
        when Hash
          symbolized_hash = symbolize_keys

          symbolized_hash.each do |key, value|
            if value.is_a?(Hash) || (modify_nested_arrays && value.is_a?(Array))
              symbolized_hash[key] = value.recursively_symbolize_keys(modify_nested_arrays)
            end
          end

          symbolized_hash
        when Array
          symbolized_array = self.dup

          symbolized_array.each_with_index do |value, index|
            symbolized_array[index] = value.recursively_symbolize_keys(true) if (value.is_a?(Hash) || value.is_a?(Array))
          end

          symbolized_array
      end
    end

    alias_method :recursive_symbolize_keys, :recursively_symbolize_keys

    # Recursively symbolize all keys in hashes.
    #
    # @param [Boolean] modify_nested_arrays set to true to modify array contents. Defaults to false.
    # @return [Hash, Array] recursively symbolized Array or Hash
    def recursively_symbolize_keys!(modify_nested_arrays = false)
      replace recursively_symbolize_keys(modify_nested_arrays)
    end

    alias_method :recursive_symbolize_keys!, :recursively_symbolize_keys!
  end
end

class Hash
  include MobmeSupport::CoreExtensions::Keys
end

class Array
  include MobmeSupport::CoreExtensions::Keys
end
