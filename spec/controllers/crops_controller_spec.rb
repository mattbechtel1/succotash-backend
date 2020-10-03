require 'rails_helper'

describe CropsController, type: :controller do

    let!(:crops) {FactoryBot.create_list(:crop, 3)}

    describe 'GET #index' do
        before {get :index}
        
        it 'returns a success response' do
            expect(response).to be_successful
        end

        it 'returns a valid JSON object with all the members' do
            expect(JSON.parse(response.body).length).to eq(3)
        end

        it 'returns a JSON object with the correct keys' do
            expect(JSON.parse(response.body)[0].keys).to include("id", "name", "pic_url", "category", "default_measure", "favorite_count")
            expect(JSON.parse(response.body)[0].keys).to_not include("favorites")
        end
    end

    describe 'POST #create' do
        context 'with valid parameters' do
            let(:valid_params) do
                {name: 'Apple', category: :fruit}
            end


            it 'returns a valid HTTP response' do
                post :create, params: {crop: valid_params}
                expect(response).to be_successful
            end

            it 'creates a new crop' do
                expect {post :create, params: {crop: valid_params}}.to change(Crop, :count).by(1)

            end

            it 'returns the crop' do
                post :create, params: {crop: valid_params}
                expect(JSON.parse(response.body)["name"]).to eq('Apple')
            end

            it 'returns the expected keys' do
                post :create, params: {crop: valid_params}
                expect(JSON.parse(response.body).keys).to include("id", "name", "pic_url", "category", "default_measure", "favorite_count")
                expect(JSON.parse(response.body).keys).to_not include("favorites")    
            end

            it 'returns a valid response even without an API key' do
                cached_key = ENV["spoonacular_api_key"]
                ENV["spoonacular_api_key"] = nil
                post :create, params: {crop: valid_params}
                expect(response).to be_successful
                ENV["spoonacular_api_key"] = cached_key
            end
        end

        context 'with invalid parameters' do
            let(:valid_params) do
                {name: 'Apple', category: "fruit"}
            end
            
            let(:unacceptable_crop) do
                {name: 'Pear', category: "unacceptable value"}
            end


            it 'returns an error when duplicating a crop' do
                post :create, params: {crop: valid_params}
                post :create, params: {crop: valid_params}
                expect(response.status).to eq(406)
            end

            it 'returns an error when given an unacceptable entry to an enumerated attribute' do
                expect {post :create, params: {crop: unacceptable_crop}}.to raise_error(ArgumentError).with_message(/is not a valid category/)
            end


        end
    end
end