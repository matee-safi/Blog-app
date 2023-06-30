require 'rails_helper'

RSpec.describe "Posts", type: :request do
    describe "GET #index each user posts" do
        before :each do
            get '/users/1/posts'
        end
        it "returns http success" do
            expect(response).to have_http_status(:success)
        end
        it "checks if the correct template was rendered" do
            expect(response).to render_template(:index)
        end
        it "checks if the response body includes the correct placeholder text" do
            expect(response.body).to include("Posts")
        end
    end
end
