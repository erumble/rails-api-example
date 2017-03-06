require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let!(:user) { create :user }
  let(:headers) { get_authorization_header(user) }
  let!(:todos) { create_list(:todo, 3, user: user) }
  let!(:items1) { create_list(:item, 10, todo_id: todos.first.id) }
  let!(:items2) { create_list(:item, 10, todo_id: todos.second.id) }
  let(:item_id) { items1.first.id }
  let(:todo_id) { todos.first.id }
  let(:valid_params) { { item: { name: 'do the things!' } } }
  let(:invalid_params) { { item: { invalid_param: 'do the things!' } } }

  authenticable_actions = [
    { method: 'get', route: '/todos/1/items' },
    { method: 'get', route: '/todos/1/items/1' },
    { method: 'post', route: '/todos/1/items' },
    { method: 'put', route: '/todos/1/items/1' },
    { method: 'delete', route: '/todos/1/items/1' }
  ]

  expect_authentication_failures_for authenticable_actions

  describe 'GET /todos/:todo_id/items' do
    context 'when todo exists' do
      context 'and items exist' do
        before { get "/todos/#{todo_id}/items", headers: headers }

        it 'returns items' do
          expect(json).not_to be_empty
        end

        it 'does not return all items' do
          expect(json.size).to eq(10)
          expect(json).not_to eq(JSON.parse(items2.to_json))
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end # context

      context 'and items do not exist' do
        before { get "/todos/#{todos.last.id}/items", headers: headers }

        it 'returns an empty json array' do
          expect(json).to eq([])
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end # context
    end # context

    context 'when todo does not exist' do
      before { get "/todos/#{todos.last.id + 1}/items", headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end # context
  end # describe GET /todos/:todo_id/items

  describe 'GET /todos/:todo_id/items/:id' do
    context 'when todo exists' do
      context 'and item exists' do
        before { get "/todos/#{todo_id}/items/#{item_id}", headers: headers }

        it 'returns an item' do
          expect(json).to eq(JSON.parse(items1.first.to_json))
        end
      end # context

      context 'and item does not exist' do
        before { get "/todos/#{todo_id}/items/#{items2.last.id + 1}", headers: headers }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
      end # context
    end # context

    context 'when todo does not exist' do
      before { get "/todos/#{todos.last.id + 1}/items/#{item_id}", headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end # context
  end # describe GET /todos/:todo_id/items/:id

  describe 'POST /todos/:todo_id/items' do
    context 'when todo exists' do
      context 'with valid params' do
        before { post "/todos/#{todo_id}/items", headers: headers, params: valid_params }

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end

        it 'returns the created item' do
          expect(json['name']).to eq(valid_params[:item][:name])
          expect(json['todo_id']).to eq(todo_id)
        end
      end # context

      context 'with invalid params' do
        before { post "/todos/#{todo_id}/items", headers: headers, params: invalid_params }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end
      end # cocontext
    end # cocontext

    context 'when todo does not exist' do
      before { post "/todos/#{todos.last.id + 1}/items", headers: headers, params: valid_params }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end # context
  end # describe POST /todos/:todo_id/items

  describe 'PUT /todos/:todo_id/items/:id' do
    context 'when todo exists' do
      context 'and item exists' do
        context 'with valid params' do
          before { put "/todos/#{todo_id}/items/#{item_id}", headers: headers, params: valid_params }

          it 'returns status code 200' do
            expect(response).to have_http_status(200)
          end

          it 'returns the updated item' do
            expect(json['name']).to eq(valid_params[:item][:name])
          end
        end # context

        context 'with invalid params' do
          before { put "/todos/#{todo_id}/items/#{item_id}", headers: headers, params: invalid_params }

          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
        end # context
      end # context

      context 'and item does not exist' do
        before { put "/todos/#{todo_id}/items/#{items2.last.id + 1}", headers: headers, params: valid_params }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
      end # context
    end # context

    context 'when todo does not exist' do
      before { put "/todos/#{todos.last.id + 1}/items/#{item_id}", headers: headers, params: valid_params }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end # context
  end # describe PUT /todos/:todo_id/items/:id

  describe 'DELETE /todos/:todo_id/items/:id' do
    context 'when todo exists' do
      context 'and item exists' do
        before { delete "/todos/#{todo_id}/items/#{item_id}", headers: headers }

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end # context

      context 'and item does not exist' do
        before { delete "/todos/#{todo_id}/items/#{items2.last.id + 1}", headers: headers }
      end # context
    end # context

    context 'when todo does not exist' do
      before { delete "/todos/#{todos.last.id + 1}/items/#{item_id}", headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end # context
  end # describe DELETE /todos/:todo_id/items/:id

end # RSpec.describe Items
