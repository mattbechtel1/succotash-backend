require 'rails_helper'

describe 'get all crops route', :type => :request do
    let!(:crops) {FactoryBot.create_list(:crop, 3)}

    before {get '/crops'}

    it 'returns all crops' do
        expect(JSON.parse(response.body).size).to eq(3)
    end

    it 'returns status code 200' do
        expect(response).to have_http_status(:success)
    end
end