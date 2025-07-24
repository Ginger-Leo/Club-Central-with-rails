require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "events contoller spec" do
    context "when user is a regular player" do
      let(:user) { create_test_user }

      before do
        login_as(user)
      end

      it "redirects to hub path" do
        post :create, params: {
          event: { datetime: 1.day.from_now, event_type: "Training", location: "Stadium" }
        }

        expect(response).to redirect_to(hub_path)
      end

      it "does not create the event" do
        expect {
          post :create, params: {
            event: { datetime: 1.day.from_now, event_type: "Training", location: "Stadium" }
          }
        }.not_to change(Event, :count)
      end
    end

    context "when user is an admin" do
      let(:admin) { create_test_admin }

      before do
        login_as(admin)
      end

      it "creates the event" do
        expect {
          post :create, params: {
            event: { datetime: 1.day.from_now, event_type: "Training", location: "Stadium" }
          }
        }.to change(Event, :count).by(1)
      end
    end
  end
end
