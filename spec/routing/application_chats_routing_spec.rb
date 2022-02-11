require "rails_helper"

RSpec.describe ApplicationChatsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/application_chats").to route_to("application_chats#index")
    end

    it "routes to #new" do
      expect(get: "/application_chats/new").to route_to("application_chats#new")
    end

    it "routes to #show" do
      expect(get: "/application_chats/1").to route_to("application_chats#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/application_chats/1/edit").to route_to("application_chats#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/application_chats").to route_to("application_chats#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/application_chats/1").to route_to("application_chats#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/application_chats/1").to route_to("application_chats#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/application_chats/1").to route_to("application_chats#destroy", id: "1")
    end
  end
end
