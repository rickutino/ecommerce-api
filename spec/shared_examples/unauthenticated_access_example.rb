shared_examples "unauthenticated access" do
  it "returns unauthorized status" do
    expext(response).to hace_http_status(:unauthorized)
  end
end