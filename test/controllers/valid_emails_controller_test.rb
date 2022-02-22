require 'test_helper'

class ValidEmailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get valid_emails_index_url
    assert_response :success
  end

end
