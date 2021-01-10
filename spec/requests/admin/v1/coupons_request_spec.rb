require 'rails_helper'

RSpec.describe "Admin::V1::Coupons", type: :request do
  let(:user) { create(:user) }

  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 5) } # "!" faz ele executar antes do request for chamado. 

    it "returns all Coupons" do
      get url, headers: auth_header(user)
      expect(body_json['coupons']).to contain_exactly *coupons.as_json(only: %i(id name code status discount_value max_use due_date))
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }

    context "with valid params" do
      let(:coupon_params) { { coupon: attributes_for(:coupon) }.to_json } 
        # Primeiro criamos uma variável coupon_params e chamamos o método attribute_for do Factory Bot. 
        # Este método retorna um hash com os dados de uma factory, que armazenamos numa chave coupon. 
        # Chamamos o to_json para que ele transforme este hash em JSON de fato para enviarmos no request.

      it "adds a new Coupon" do
        expect do #Criando bloco
          post url, headers: auth_header(user), params: coupon_params
        end.to change(Coupon, :count).by(1) # verificando se ouve um acrecimento de 1 unidade.
      end

      it "returns last added Coupon" do
        post url, headers: auth_header(user), params: coupon_params
        expected_coupon = Coupon.last.as_json(only: %i(id name code status discount_value max_use due_date))
        expect(body_json['coupon']).to eq expected_coupon
      end

      it "returns sucess status" do
        post url, headers: auth_header(user), params: coupon_params
        expect(response).to have_http_status(:ok) # agora utilizando o matcher have_http_status para validar o status da resposta como :ok (200)
      end
    end

    context "with invalid params" do
      # Criamos uma variável coupon_invalid_params com a factory de coupon, 
      # porém dessa vez estamos colocando o nome como vazio, 
      # pois já sabemos que ele é um atributo obrigatório.
      let(:coupon_invalid_params) do
        { coupon: attributes_for(:coupon, name: nil) }.to_json
      end

      it "does not add a new Coupon" do
        # fazemos o POST com estes parâmetros inválidos que estamos nos certificando 
        # que coupon não possui nenhuma alteração na contagem.
        expect do
          post url, headers: auth_header(user), params: coupon_invalid_params
        end.to_not change(Coupon, :count)
      end

      it "returns error message" do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it "returns unprocessable_entity status" do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end
end
