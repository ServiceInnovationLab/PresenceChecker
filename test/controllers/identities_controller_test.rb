require 'test_helper'

class IdentitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @identity = identities(:one)
  end

  test "should get index" do
    get identities_url
    assert_response :success
  end

  test "should get new" do
    get new_identity_url
    assert_response :success
  end

  test "should create identity" do
    assert_difference('Identity.count') do
      post identities_url, params: { identity: { identity: @identity.identity } }
    end

    assert_redirected_to identity_url(Identity.last)
  end

  test "should show identity" do
    get identity_url(@identity)
    assert_response :success
  end

  test "should get edit" do
    get edit_identity_url(@identity)
    assert_response :success
  end

  test "should update identity" do
    patch identity_url(@identity), params: { identity: { identity: @identity.identity } }
    assert_redirected_to identity_url(@identity)
  end

  test "should destroy identity" do
    assert_difference('Identity.count', -1) do
      delete identity_url(@identity)
    end

    assert_redirected_to identities_url
  end
end
