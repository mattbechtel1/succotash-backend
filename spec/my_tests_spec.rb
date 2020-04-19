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

describe 'Field is valid when', :type => :model do
    user = User.new(username: 'Mike')
    valid_field = Field.new(user: user, name: "#{Faker::ProgrammingLanguage.unique.name} Field")
    field_without_owner = Field.new(name: 'pipsqueak')
    field_wihtout_name = Field.new(user: user)
    new_field = Field.new(user: user, name: 'new')

    it 'it has a valid user and username' do
        expect(valid_field).to be_valid
        expect(field_wihtout_name).to be_invalid
        expect(field_without_owner).to be_invalid
    end

    it "it's name is not literally 'new'" do
        expect(new_field).to be_invalid
    end

    it "it's slug is not duplicative" do
        slug_field = Field.new(user: user, name: 'my-field')
        slug_field2 = Field.new(user: user, name: 'my field')
        expect(slug_field2).to be_invalid
    end

end