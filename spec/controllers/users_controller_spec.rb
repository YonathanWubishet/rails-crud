# frozen_string_literal: true

require 'rails_helper'
describe UsersController do
  describe '#index' do
    subject { get :index }
    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end
    it 'should return proper json' do
      create_list :user, 2
      subject
      User.recent.each_with_index do |user, index|
        expect(json_data[index]['attributes']).to eq({
                                                       'id' => user.id,
                                                       'first_name' => user.first_name,
                                                       'last_name' => user.last_name,
                                                       'email' => user.email,
                                                       'avatar' => user.avatar
                                                     })
      end
    end
    it 'should return users in the proper order' do
      old_user = create :user
      newer_user = create :user
      subject
      expect(json_data.first['id']).to eq(newer_user.id.to_s)
      expect(json_data.last['id']).to eq(old_user.id.to_s)
    end
    it 'should paginate results' do
      create_list :user, 3
      get :index, params: { page: 2, per_page: 1 }
      expect(json_data.length).to eq 1
      expected_user = User.recent.second.id.to_s
      expect(json_data.first['id']).to eq(expected_user)
    end
  end
  describe '#show' do
    let(:user) { create :user }
    subject { get :show, params: { id: user.id } }
    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end
    it 'should return proper json' do
      subject
      expect(json_data['attributes']).to eq({
                                              'id' => user.id,
                                              'first_name' => user.first_name,
                                              'last_name' => user.last_name,
                                              'email' => user.email,
                                              'avatar' => user.avatar
                                            })
    end
  end
end
