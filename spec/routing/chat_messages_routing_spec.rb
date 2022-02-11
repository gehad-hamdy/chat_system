require "rails_helper"

RSpec.describe ChatMessagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/chat_messages").to route_to("chat_messages#index")
    end

    it "routes to #new" do
      expect(get: "/chat_messages/new").to route_to("chat_messages#new")
    end

    it "routes to #show" do
      expect(get: "/chat_messages/1").to route_to("chat_messages#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/chat_messages/1/edit").to route_to("chat_messages#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/chat_messages").to route_to("chat_messages#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/chat_messages/1").to route_to("chat_messages#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/chat_messages/1").to route_to("chat_messages#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/chat_messages/1").to route_to("chat_messages#destroy", id: "1")
    end
  end
end
