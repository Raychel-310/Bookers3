require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get books_top_url
    assert_response :success
  end
end
