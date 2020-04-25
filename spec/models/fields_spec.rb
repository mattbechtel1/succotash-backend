require 'rails_helper'

describe Field, type: :model do

    let!(:user) {FactoryBot.create(:user)}

    let(:valid__simple_field) do
        {name: 'My field', user: user}
    end

    let(:valid_complex_field) do
        {name: 'My complex field', x_axis_count: 6, y_axis_count: 6, user: user}
    end

    let(:invalid_new_field) do
        {name: 'new', user: user}
    end

    let(:invalid_userless_field) do
        {name: 'unowned field'}
    end

    describe '#populate_beds' do
        let(:new_field) {Field.new(valid_complex_field)}
        let(:created_field) {Field.create(valid_complex_field)}
        let(:simple_created_field) {Field.create(valid__simple_field)}

        it 'does not work on unsaved fields' do
            new_field.populate_beds
            expect(new_field.beds.count).to eq(0)
        end

        it 'is called on #create and assigns the correct number of beds' do
            expect(created_field.beds.count).to eq(36)
        end

        it 'assigns exactly one bed by default there no axis-counts are provided' do
            expect(simple_created_field.beds.count).to eq(1)
        end
    end

    describe '#slug' do
        let(:created_field) {Field.create(valid_complex_field)}
        let(:duplicated_field) {Field.new(valid_complex_field)}
        let(:new_field) {Field.new(invalid_new_field)}


        it 'is correctly assigned on #create' do
            expect(created_field.slug).to eq('my-complex-field')
        end

        it 'cannot be duplicated' do
            expect(created_field).to be_valid
            expect(duplicated_field).to_not be_valid
        end

        it "cannot be the word 'new'" do
            expect(new_field).to_not be_valid
        end
    end

    describe '#user' do
        let(:field) {Field.new(valid_complex_field)}
        let(:userless_field) {Field.new(invalid_userless_field)}

        it 'returns the user object' do
            expect(field.user).to be_kind_of(User)
        end

        it 'must be present for the field to be valid' do
            expect(userless_field).to_not be_valid
        end
    end

end