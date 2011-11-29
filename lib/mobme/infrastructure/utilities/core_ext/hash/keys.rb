# Gems
require 'active_support/core_ext/hash/keys'

# Local
require_relative '../../version'

module MobME::Infrastructure::Utilities::CoreExtensions
  # Hash extension, allowing recursive Hash key symbolization
  module Keys
    # Recursively symbolize all keys in the hash.
    def recursively_symbolize_keys!
      if self.is_a?(Hash)
        self.symbolize_keys!
        self.values.select {|v| v.is_a?(Hash) || v.is_a?(Array) }.map!(&:recursively_symbolize_keys!)
      elsif self.is_a?(Array)
        self.select {|v| v.is_a?(Hash) || v.is_a?(Array) }.map!(&:recursively_symbolize_keys!)
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
