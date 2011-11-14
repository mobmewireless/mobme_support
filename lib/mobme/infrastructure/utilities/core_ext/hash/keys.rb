# Gems
require 'active_support/core_ext/hash/keys'

# Local
require_relative '../../version'

module MobME::Infrastructure::Utilities::CoreExtensions
  module Keys
    def recursive_symbolize_keys!
      recursively_symbolize_keys!
    end
    
    # Recursively symbolize all keys in the hash.
    def recursively_symbolize_keys!
      self.symbolize_keys!
      self.values.select { |v| v.is_a? Hash }.each { |h| h.recursively_symbolize_keys! }
    end
  end
end

class Hash
  include MobME::Infrastructure::Utilities::CoreExtensions::Keys
end