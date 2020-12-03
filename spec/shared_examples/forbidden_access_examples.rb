shared_examples "forbidden access" do 
  it "returns error message" do 
    expect(body_json['errors']['message']).to eq "Forbidden access"
  end

  it "returs forbidden status" do
    expext(response).to have_http_status(:forbidden)
  end
end