# MobME Support library
#
# A collection of classes and standard library extensions extracted from across MobME projects, which serves to avoid
# re-writing often-used code.
module MobmeSupport
  # Gem Version
  def self.version
    Gem::Version.new '3.0.0'
  end

  # Operations on files.
  module FileOperations end

  # Extensions to core Ruby classes.
  module CoreExtensions end
end
