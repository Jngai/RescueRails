require 'rails_helper'

feature 'visit dog show page', js: true do
  before(:each) do
    visit dog_path(adoption_completed_dog)
  end

  context 'when the dog adoption is completed' do
    let(:adoption_completed_dog){FactoryBot.create(:dog, status: 'completed')}
    it 'should show alert to inform user' do
      expect(page).to have_selector('.alert.alert-error h4', text: "Sorry, this dog is no longer available for adoption!")
      expect(page).to have_selector('.alert.alert-error', text: "Please see our gallery of")
      expect(page).to have_selector('.alert.alert-error a', text: "available dogs")
    end
  end
end
