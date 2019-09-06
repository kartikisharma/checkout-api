require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  # initialize test data
  let!(:items) { create_list(:item, 10) }
  let(:item_id) { items.first.id }

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

  describe 'GET /items/:id' do
    before { get "/items/#{item_id}"}

    context 'when the record exists' do
      it 'returns the item' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(item_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:item_id) { 34 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /items' do
    let(:valid_attrs) { { name: 'Camera', available: false } }

    context 'when the request is valid' do
      before { post '/items', params: valid_attrs }

      it 'creates a item' do
        expect(json['name']).to eq('Camera')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/items', params: { name: 'Camera' } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a validation failure message' do
        expect(response.body)
        .to match(/Validation failed: Available can't be blank/)
      end
    end
  end

  describe 'PUT /items/:id' do
    let(:valid_attrs) { { name: 'Camera', available: false } }

    context 'when the record exists' do
      before { put "/items/#{item_id}", params: valid_attrs }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /items/:id' do
    before { delete "/items/#{item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
