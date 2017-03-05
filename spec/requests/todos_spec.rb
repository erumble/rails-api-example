require 'rails_helper'

RSpec.describe "Todos", type: :request do
  let!(:user) { create :user }
  let(:headers) { authenticate_user(user) }
  let!(:todos) { create_list(:todo, 10, user: user) }
  let(:todo_id) { todos.first.id }

  describe "GET /todos" do
    before { get '/todos', headers: headers }

    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end # describe GET /todos

  describe 'GET /todos/:id' do
    before { get "/todos/#{todo_id}", headers: headers }

    context 'when the record exists' do
      it 'returns a todo object' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end # context

    context 'when the record does not exist' do
      let(:todo_id) { todos.last.id + 1 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end #context
  end # describe GET /todos/:id

  describe 'POST /todos' do
    let(:valid_attributes) { { todo: { title: 'stuff' } } }
    let(:invalid_attributes) { { todo: { invalid: 'param' } } }

    context 'with valid attributes' do
      before { post '/todos', headers: headers, params: valid_attributes }

      it 'creates a todo' do
        expect(json['title']).to eq(valid_attributes[:todo][:title])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end # context

    context 'with invalid attributes' do
      before { post '/todos', headers: headers, params: invalid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end # context

    context 'with no attributes' do
      before { post '/todos', headers: headers, params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end # context
  end # describe POST /todos

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { todo: { title: 'stuff' } } }
    let(:invalid_attributes) { { todo: { invalid: 'param' } } }

    context 'when the record exists' do
      context 'with valid attributes' do
        before { put "/todos/#{todo_id}", headers: headers, params: valid_attributes }

        it 'updates the record' do
          expect(json['title']).to eq(valid_attributes[:todo][:title])
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end # context

      context 'with invalid attributes' do
        before { put "/todos/#{todo_id}", headers: headers, params: invalid_attributes }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end # context
    end # context

    context 'when the record does not exist' do
      before { put "/todos/#{todos.last.id + 1}", headers: headers, params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end # context
  end # describe PUT /todos/:id

  describe 'DELETE /todos/:id' do
    context 'when the record exists' do
      before { delete "/todos/#{todo_id}", headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end #context

    context 'when the record does not exist' do
      before { delete "/todos/#{todos.last.id + 1}", headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end # context
  end # describe DELETE /todos/:id
end # RSpec.describe "Todos"
