module MobME::Infrastructure::Utilities
  module MSISDN
    def msisdn
      msisdn = self.strip
      msisdn[-10..-1] if msisdn.match(/^(\+|00)?(91)?(9|8|7)[0-9]{9}$/)
    end

    def msisdn?
      msisdn ? true : false
    end
  end
end

class String
  include MobME::Infrastructure::Utilities::MSISDN
end
