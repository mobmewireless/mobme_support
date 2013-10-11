# Local
require_relative '../../version'

module MobmeSupport::CoreExtensions
  # String extension, which allows URL validation
  module URL
    # Validates and converts a URL to standard format (if applicable)
    #
    # @return [String, nil] Validated MSISDN, or nil
    # @example Validate a URL without scheme
    #   "google.com".url
    #   >> "http://google.com"
    # @example Validate a URL with server IP
    #   "https://123.234.123.234/path/to/item".url
    #   >> "https://123.234.123.234/path/to/item"
    # @example Validate a file:// URL
    #   "file:///absolute/path/to/file".url
    #   >> "file:///absolute/path/to/file"
    # @example Validate a scp:// URL
    #   "scp://user@server:/path/to/resource".url
    #   >> "scp://user@server:/path/to/resource"
    def url
      possible_url = self.strip
      reg = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
      first_match = reg.match(possible_url) ? possible_url : nil
      unless first_match
        reg = /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
        second_match = reg.match(possible_url) ? 'http://' + possible_url : nil
        unless second_match
          reg = /^(http|https):\/\/[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9](\/.*)?$/ix
          third_match = reg.match(possible_url) ? possible_url : nil
          unless third_match
            reg = /^[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9](\/.*)?$/ix
            fourth_match = reg.match(possible_url) ? 'http://' + possible_url : nil
            unless fourth_match
              reg = /^file:\/\/(\/[a-z0-9_-]+)*\/([a-z0-9_-]+)+(\.([a-z0-9]+)+)?$/ix
              fifth_match = reg.match(possible_url) ? possible_url : nil
              unless fifth_match
                reg = /^scp:\/\/[a-z0-9_-]+@[a-z0-9_-]+:(\/[a-z0-9_-]+)*\/([a-z0-9_-]+)+(\.([a-z0-9]+)+)?$/ix
                sixth_match = reg.match(possible_url) ? possible_url : nil
                unless sixth_match
                  reg = /^scp:\/\/[a-z0-9_-]+@[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]\.[12]?[0-9]?[0-9]:(\/[a-z0-9_-]+)*\/([a-z0-9_-]+)+(\.([a-z0-9]+)+)?$/ix
                  seventh_match = reg.match(possible_url) ? possible_url : nil
                  unless seventh_match
                    reg = /^scp:\/\/[a-z0-9_-]+@[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}:(\/[a-z0-9_-]+)*\/([a-z0-9_-]+)+(\.([a-z0-9]+)+)?$/ix
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

    # Validates a URL
    #
    # @return [Boolean] True if string is a valid URL. False, otherwise
    # @example URL without scheme
    #   "google.com".url?
    #   >> true
    # @example URL with invalid scheme
    #   "foobar://123.234.123.234/path/to/item".url
    #   >> false
    # @example file:// path with invalid characters
    #   "file:///p@th/w!th/!nval!d/ch@r@cters".url
    #   >> false
    def url?
      url ? true : false
    end
  end
end

class String
  include MobmeSupport::CoreExtensions::URL
end
