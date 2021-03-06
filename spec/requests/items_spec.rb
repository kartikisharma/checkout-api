require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  # initialize test data
  let!(:items) { create_list(:item, 10) }
  let(:item_barcode) { items.first.barcode }

  describe 'GET /items' do
    before { get '/items' }

    it 'returns items' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /items/:item_barcode' do
    before { get "/items/#{item_barcode}"}

    context 'when the record exists' do
      it 'returns the item' do
        expect(json).not_to be_empty
        expect(json['barcode']).to eq(item_barcode)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:item_barcode) { 34 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /items' do
    let(:valid_attrs) { { name: 'Camera', barcode: '2034954', available: false } }

    context 'when the request is valid' do
      before { post '/items', params: valid_attrs}

      it 'creates a item' do
        expect(json['name']).to eq('Camera')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid with missing barcode and available' do
      before { post '/items', params: { name: 'Camera' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the request is invalid with missing barcode' do
      before { post '/items', params: { name: 'Camera', available: false } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the request is invalid with missing available' do
      before { post '/items', params: { name: 'Camera', barcode: '023459'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /items/:item_barcode' do
    let(:valid_attrs) { { name: 'Camera', barcode: '2034954', available: false } }

    context 'when the record exists' do
      before { put "/items/#{item_barcode}", params: valid_attrs }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /items/:item_barcode' do
    before { delete "/items/#{item_barcode}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
