module MobME::Infrastructure::Utilities
  module URL
    def url
      possible_url = self.strip
      reg = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
      first_match = reg.match(possible_url) ? possible_url : nil
      unless first_match
        reg = /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
        second_match = reg.match(possible_url) ? "http://" + possible_url : nil
        unless second_match
          reg = /^(http|https):\/\/[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9](\/.*)?$/ix
          third_match = reg.match(possible_url) ? possible_url : nil
          unless third_match
            reg = /^[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9](\/.*)?$/ix
            fourth_match = reg.match(possible_url) ? "http://" + possible_url : nil
            unless fourth_match
              reg = /^file:\/\/(\/[a-z0-9_-]+)*\/([a-z0-9_-]+)+(\.([a-z0-9]+)+)?$/ix
              fifth_match = reg.match(possible_url) ? possible_url : nil
              unless fifth_match
                reg = /^scp:\/\/[a-z0-9_-]+@[a-z0-9_-]+:~?(\/[a-z0-9_-]+)*\/([a-z0-9_-]+)+(\.([a-z0-9]+)+)?$/ix
                sixth_match = reg.match(possible_url) ? possible_url : nil
                unless sixth_match
                  reg = /^scp:\/\/[a-z0-9_-]+@[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]:~?(\/[a-z0-9_-]+)*\/([a-z0-9_-]+)+(\.([a-z0-9]+)+)?$/ix
                  seventh_match = reg.match(possible_url) ? possible_url : nil
                  unless seventh_match
                    reg = /^scp:\/\/[a-z0-9_-]+@[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}:~?(\/[a-z0-9_-]+)*\/([a-z0-9_-]+)+(\.([a-z0-9]+)+)?$/ix
                    reg.match(possible_url) ? possible_url : nil
                  else
                    seventh_match
                  end
                else
                  sixth_match
                end
              else
                fifth_match
              end
            else
              fourth_match
            end
          else
            third_match
          end
        else
          second_match
        end
      else
        first_match
      end
    end

    def url?
      url ? true : false
    end
  end
end

class String
  include MobME::Infrastructure::Utilities::URL
end
