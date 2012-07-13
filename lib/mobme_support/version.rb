module MobME
  module Infrastructure
    # Collection of classes and standard library extensions extracted from across MobME projects, which serves to avoid re-writing often-used
    # code.
    module Utilities
      # Version string.
      VERSION = '2.2.3'

      # Extensions to core Ruby classes.
      module CoreExtensions
      end

      # Operations on files.
      module FileOperations
      end
    end
  end
end

# Alias it!
MobMESupport = MobME::Infrastructure::Utilities
