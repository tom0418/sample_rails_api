require "rails_helper"

RSpec.describe "Items API", type: :request do
  # Initialize test data
  let!(:todo) { create(:todo) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { Item.first.id }

  # Test suite for GET /todos/:todo_id/items
  describe "GET /todos/:todo_id/items" do
    before { get "/todos/#{todo_id}/items" }

    context "when the todo exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns all todo items" do
        expect(json.size).to eq(20)
      end
    end

    context "when the todo not exist" do
      let(:todo_id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        expect(response.body).to match("Record not found")
      end
    end
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe "GET /todos/:todo_id/items/:id" do
    before { get "/todos/#{todo_id}/items/#{id}" }

    context "when the todo item exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the item" do
        expect(json["id"]).to eq(id)
      end
    end

    context "when the todo item not exist" do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        expect(response.body).to match("Record not found")
      end
    end
  end

  # Test suite for POST /todos/:todo_id/items
  describe "POST /todos/:todo_id/items" do
    let(:valid_attributes) { { item: { name: "Test User" } } }

    before { post "/todos/#{todo_id}/items", params: valid_attributes }

    context "when request is valid" do
      it "returns status code 201" do
        expect(response).to have_http_status(:created)
      end
    end

    context "when request is invalid" do
      let(:invalid_attibutes) { { item: { name: "" } } }

      before { post "/todos/#{todo_id}/items", params: invalid_attibutes }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a validation failure message" do
        expect(response.body).to match("Validation failed: Name can't be blank")
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items/:id
  describe "PUT /todos/:todo_id/items/:id" do
    let(:valid_attributes) { { item: { name: "Foobar" } } }

    before { put "/todos/#{todo_id}/items/#{id}", params: valid_attributes }

    context "when the item exists" do
      it "returns status code 201" do
        expect(response).to have_http_status(:no_content)
      end

      it "updates the item" do
        update_item = Item.find(id)
        expect(update_item.name).to eq("Foobar")
      end
    end

    context "when the item not exist" do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        expect(response.body).to match("Record not found")
      end
    end

    context "when request is invalid" do
      let(:invalid_attributes) { { item: { name: "" } } }

      before { put "/todos/#{todo_id}/items/#{id}", params: invalid_attributes }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a validation failure message" do
        expect(response.body).to match("Validation failed: Name can't be blank")
      end
    end
  end

  # Test suite for DELETE /todos/:todo_id/items/:id
  describe "DELETE /todos/:todo_id/items/:id" do
    before { delete "/todos/#{todo_id}/items/#{id}" }

    context "when the item exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the item not exist" do
      let(:id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        expect(response.body).to match("Record not found")
      end
    end
  end
end
