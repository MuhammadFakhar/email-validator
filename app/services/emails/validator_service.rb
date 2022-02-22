module Emails
  class ValidatorService
    BASE_URL = "http://apilayer.net/api/"

    def initialize(possible_email_addresses)
      @possible_email_addresses = possible_email_addresses
    end

    def call
      validate_email
    end

    private
      def validate_email
        @possible_email_addresses.each do |email_address|
          unless already_available?(email_address)
            response = HTTParty.get("#{BASE_URL}check?access_key=#{ENV['MAILBOXLAYER_ACCESS_KEY']}&email=#{email_address}")
            response = JSON.parse(response.body)

            if check_validity(response)
              email = format_email(response)
              ValidEmail.create!(email: email)
              return
            end
          end
        end
      end

      def check_validity(response)
        response['format_valid'] == true && response['mx_found'] == true && response['smtp_check'] == false &&
        response['catch_all'] == false
      end

      def already_available?(email_address)
        valid_email = ValidEmail.find_by(email: email_address)
      end

      def format_email(response)
        response = response['email'].split(' ').second.gsub('<', '')
        formated_email = response.gsub('>', '')
      end
  end
end
