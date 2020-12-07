shared_examples "forbidden access" do
  it "returns error message" do
    # logger.info("Logger created".yellow)
    # binding.pry
    expect(body_json['errors']['message']).to eq "Forbidden access"
  end

  it "returs forbidden status" do
    expect(response).to have_http_status(:forbidden)
  end
end