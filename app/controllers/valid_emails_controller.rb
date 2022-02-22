class ValidEmailsController < ApplicationController
  def index
    @valid_emails = ValidEmail.all
  end

  def search
    first_name = params[:first_name].downcase
    last_name = params[:last_name].downcase
    url = params[:url].downcase

    possible_email_addresses = possible_email_combinations(first_name, last_name, url)
    validator = Emails::ValidatorService.new(possible_email_addresses)
    if validator.call
      redirect_to valid_emails_path
    end
  end

  private

  def possible_email_combinations(first_name, last_name, url)
    possible_email_addresses = []

    possible_email_addresses << first_name+"."+last_name+"@"+url
    possible_email_addresses << first_name+"@"+url
    possible_email_addresses << first_name+last_name+"@"+url
    possible_email_addresses << last_name+"."+first_name+"@"+url
    possible_email_addresses << first_name.first+"."+last_name+"@"+url
    possible_email_addresses << first_name.first+"."+last_name.first+"@"+url
  end
end
