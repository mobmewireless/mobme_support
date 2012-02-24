# Gems
require 'active_support/core_ext/hash/keys'

# Local
require_relative '../../version'

module MobME::Infrastructure::Utilities::CoreExtensions
  # Hash extension, allowing recursive Hash key symbolization
  module Keys
    # Recursively symbolize all keys in the hash.
    def recursively_symbolize_keys!(modify_nested_arrays = false)
      case self
      when Hash
        symbolize_keys!

        each do |key, value|
          if value.is_a?(Hash) || (modify_nested_arrays && value.is_a?(Array))
            self[key] = value.dup.recursively_symbolize_keys!(modify_nested_arrays)
          end
        end
      when Array
        each_with_index do |value, index|
          self[index] = value.dup.recursively_symbolize_keys!(true) if (value.is_a?(Hash) || value.is_a?(Array))
        end
      end

      self
    end

    alias_method :recursive_symbolize_keys!, :recursively_symbolize_keys!
  end
end

class Hash
  include MobME::Infrastructure::Utilities::CoreExtensions::Keys
end

class Array
  include MobME::Infrastructure::Utilities::CoreExtensions::Keys
end
