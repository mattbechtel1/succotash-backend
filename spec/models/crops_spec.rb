require 'rails_helper'

describe Crop, type: :model do
    let(:valid_crop) do
        {name: 'Apple', category: :fruit}
    end

    let(:crazy_crop) do
        {name: 'fdkslahiasdf', category: 'legume'}
    end

    describe '#pic_url', :spoonacular do
        let(:new_crop) {Crop.new(valid_crop)}
        let(:created_crop) {Crop.create(valid_crop)}
        let(:new_crazy_crop) {Crop.new(crazy_crop)}
        let(:created_crazy_crop) {Crop.create(crazy_crop)}

        it 'is not initialized on #new' do
            expect(new_crop.pic_url).to be_nil
            expect(new_crazy_crop.pic_url).to be_nil
        end

        it 'is set after calling #set_pic on a normal crop' do
            new_crop.set_pic
            expect(new_crop.pic_url).to be_a_kind_of(String)
        end

        it 'is not set after calling #set_pic on a non-food item' do
            new_crazy_crop.set_pic
            expect(new_crazy_crop.pic_url).to be_nil
        end

        it 'is set on #create for a normal crop' do
            expect(created_crop.pic_url).to be_a_kind_of(String)
        end

        it 'remains falsey on #create for a non-food item' do
            expect(created_crazy_crop.pic_url).to be_nil
        end
    end

    describe '#name' do
        let(:capital_crop) do
            {name: 'aPPLe'}
        end

        let(:new_crop) {Crop.new(valid_crop)}
        let(:created_crop) {Crop.create(valid_crop)}
        let(:other_apple) {Crop.new(valid_crop)}
        let(:messy_crop) {Crop.new(capital_crop)}

        it 'returns the name of the Crop' do
            expect(new_crop.name).to eq('Apple')
            expect(created_crop.name).to eq('Apple')
        end

        it 'cannot be duplicated' do
            expect(created_crop).to be_valid
            expect(other_apple).to_not be_valid
        end

        it 'cannot be duplicated even when capitalization is different' do
            expect(created_crop).to be_valid
            expect(messy_crop).to_not be_valid
        end
    end

    describe '#category' do
        let(:unacceptable_crop) do
            {name: 'Pear', category: :unacceptable_value}
        end

        let(:new_crop) {Crop.new(valid_crop)}
        let(:messy_crop) {Crop.new(crazy_crop)}



        it 'can be set with a symbol' do
            expect(new_crop.category).to eq('fruit')
        end

        it 'can be set with a string' do
            expect(messy_crop.category).to eq('legume')
        end

        it 'can be determined with a Boolean' do
            expect(messy_crop.legume?).to be true
            expect(new_crop.legume?).to be false
        end

        it 'can be updated' do
            messy_crop.vegetable!
            new_crop.category = :herb
            expect(messy_crop.category).to eq('vegetable')
            expect(new_crop.category).to eq('herb')
        end

        it 'cannot accept unapproved values' do
            expect {Crop.new(unacceptable_crop)}.to raise_error(ArgumentError).with_message(/is not a valid category/)
        end
    end

    describe '#fav_count' do
        let(:new_crop) {Crop.new(valid_crop)}

        it 'should display the number of times the crop has been favorited' do
            user = build(:user)
            expect true

        end

    end

end