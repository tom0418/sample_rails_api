require "rails_helper"

RSpec.describe "Todos API", type: :request do
  # initialize test data
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { Todo.first.id }

  # Test suite for GET /todos
  describe "GET /todos" do
    before { get "/todos" }

    it "returns status code 200" do
      expect(response).to have_http_status(:ok)
    end

    it "return todos" do
      expect(json.size).to eq(10)
    end
  end

  # Test suite for GET /todos/:id
  describe "GET /todos/:id" do
    before { get "/todos/#{todo_id}" }

    context "when the record exists" do
      it "returns status code 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns the todo" do
        expect(json["id"]).to eq(todo_id)
      end
    end

    context "when the record not exist" do
      let(:todo_id) { 0 }

      it "returns status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        expect(response.body).to match("Record not found")
      end
    end
  end

  # Test suite for POST /todos
  describe "POST /todos" do
    context "when the request is valid" do
      let(:valid_attributes) { { todo: { title: "Learn Elm", created_by: "1" } } }

      before { post "/todos", params: valid_attributes }

      it "returns status code 201" do
        expect(response).to have_http_status(:created)
      end

      it "creates a todo" do
        expect(json["title"]).to eq("Learn Elm")
      end
    end

    context "when the request is invalid" do
      let(:invalid_attributes) { { todo: { title: "Foobar", created_by: "" } } }

      before { post "/todos", params: invalid_attributes }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a validation failure message" do
        expect(response.body).to match("Validation failed: Created by can't be blank")
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe "PUT /todos/:id" do
    let(:valid_attributes) { { todo: { title: "Shopping" } } }

    context "when the record exists" do
      before { put "/todos/#{todo_id}", params: valid_attributes }

      it "returns status code 204" do
        expect(response).to have_http_status(:no_content)
      end

      it "updates the record" do
        expect(response.body).to be_empty
      end
    end

    context "when the record not exits" do
      let(:todo_id) { 0 }

      before { put "/todos/#{todo_id}", params: valid_attributes }

      it "returns status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        expect(response.body).to match("Record not found")
      end
    end

    context "when the request is invalid" do
      let(:invalid_attributes) { { todo: { title: "Foobar", created_by: "" } } }

      before { put "/todos/#{todo_id}", params: invalid_attributes }

      it "returns status code 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a validation failure message" do
        expect(response.body).to match("Validation failed: Created by can't be blank")
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe "DELETE /todos/:id" do
    before { delete "/todos/#{todo_id}" }

    context "when the record exists" do
      it "returns status code 204" do
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the record not exist" do
      let(:todo_id) { 0 }

      before { delete "/todos/#{todo_id}" }

      it "returns status code 404" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns a not found message" do
        expect(response.body).to match("Record not found")
      end
    end
  end
end
