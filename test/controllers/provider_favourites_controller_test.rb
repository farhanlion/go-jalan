require 'test_helper'

class ProviderFavouritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get provider_favourites_index_url
    assert_response :success
  end

  test "should get create" do
    get provider_favourites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get provider_favourites_destroy_url
    assert_response :success
  end

end
