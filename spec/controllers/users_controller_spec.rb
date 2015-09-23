require 'rails_helper'

describe UsersController, type: :controller do

  let!(:admin) {create(:user, :admin)}
  let!(:hacker) {create(:user)}

  describe 'POST create' do
    context 'logged in as an admin' do
      before :each do
        allow(controller).to receive(:current_user) { admin }
      end

      it 'is able to create a user' do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end
    end

    context 'logged in as normal user' do
      before :each do
        allow(controller).to receive(:current_user) { hacker }
      end

      it 'is unable to create a user' do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User, :count).by(0)
      end

    end

  end

  describe 'PUT update' do
    let(:test_user) { create(:user, admin: FALSE) }
    let(:request) { -> {put :update, id: test_user.id, user: attributes_for(:user, admin: TRUE)} }

    context 'logged in as admin' do
      before :each do
        allow(controller).to receive(:current_user) { admin }
      end

      it 'updates the users permissions' do
        expect { request.call }.to change{ test_user.reload.admin }.from(FALSE).to(TRUE)
      end

    end

    context 'logged in as normal user' do
      before :each do
        allow(controller).to receive(:current_user) { hacker }
      end

      it 'is unable to modify user permissions' do
        expect { request.call }.to_not change{ test_user.reload.admin }
      end

    end

  end

end