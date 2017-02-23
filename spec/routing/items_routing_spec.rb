require "rails_helper"

RSpec.describe ItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "todos/1/items").to route_to("items#index", :todo_id => "1")
    end

    it "routes to #show" do
      expect(:get => "todos/1/items/1").to route_to("items#show", :id => "1", :todo_id => "1")
    end

    it "routes to #create" do
      expect(:post => "todos/1/items").to route_to("items#create", :todo_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "todos/1/items/1").to route_to("items#update", :id => "1", :todo_id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "todos/1/items/1").to route_to("items#update", :id => "1", :todo_id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "todos/1/items/1").to route_to("items#destroy", :id => "1", :todo_id => "1")
    end

  end
end
