require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "UsersController" do
    describe "Get INDEX" do
      it 'lists all the users' do
        user = User.create(name: "John Doe", password: 'Aaasdfghjkl100')
        get root_path
        expect(response.status).to eq(200)
        expect(response.body).to include("John Doe")
      end
    end

    describe "POST #import" do
      let(:file) { fixture_file_upload('users.csv') }
      it "redirects to the home page" do
        post import_users_path, params: {file: file}
        expect(response).to redirect_to root_url
        expect(response.status).to eq(302)
      end

      it 'should show the correct flash messages' do
        post import_users_path, params: {file: file}
        @flash_notices = flash[:notice]
        expect(@flash_notices).to eq ["Muhammad was successfully saved", "Change 1 character of Maria Turing's password", "Change 4 characters of Isabella's password", "Change 5 characters of Axel's password"]
        expect(response.status).to eq(302)
      end
    end
  end
end
