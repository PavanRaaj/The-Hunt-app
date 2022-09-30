require "test_helper"

class IntervieweeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get interviewee_index_url
    assert_response :success
  end
end
