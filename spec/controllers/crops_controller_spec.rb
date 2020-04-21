require 'rails_helper'

describe CropsController, type: :controller do
    let(:valid_crop) {
        {name: 'Apple'}
    }

    let(:valid_session) { {} }

    describe 'GET #index' do
        it 'returns a success response' do
            Crop.create valid_crop
            get :index, params: {}, session: valid_session
            expect(response).to be_successful
        end
    end
end