require 'test_helper'

class ServiceFavouritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get service_favourites_index_url
    assert_response :success
  end

  test "should get create" do
    get service_favourites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get service_favourites_destroy_url
    assert_response :success
  end

end
