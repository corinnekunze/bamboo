require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /recipes/:id' do
    context 'when recipe present' do
      let!(:recipe) { FactoryBot.create(:recipe) }

      it 'returns recipe json' do
        get "/recipes/#{recipe.id}", as: :json
        expect(response.body).to eq(recipe.to_json)
      end
    end

    context 'when recipe not present' do
      it 'returns 404' do
        get '/recipes/66', as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /recipes' do
    it 'creates recipe' do
      expect do
        post '/recipes', params: { name: 'First', body: { 'test': 'example' } }, as: :json
      end.to change(Recipe, :count).by(1)
    end

    context 'when invalid params' do
      it 'returns errors' do
        post '/recipes', params: {}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /recipes/:id' do
    context 'when recipe present' do
      let!(:recipe) { FactoryBot.create(:recipe) }
      it 'deletes recipe', :aggregate_failures do
        expect do
          delete "/recipes/#{recipe.id}", as: :json
        end.to change(Recipe, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when recipe not present' do
      it 'returns a 404' do
        delete '/recipes/123', as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
