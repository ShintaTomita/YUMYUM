# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Yumyum::ChefsController, type: :request do
  describe 'YumYum::ChefsController' do
    let!(:chef) { create(:chef) }

    before do
      sign_in chef
      get yumyum_chefs_path
    end

    it 'ページが表示されるか' do
      expect(response).to have_http_status(200)
      get "/yumyum/chefs/#{chef.id}"
      expect(response).to have_http_status(200)
      get "/yumyum/chefs/#{chef.id}/edit"
      expect(response).to have_http_status(200)
      get new_yumyum_chef_path
      expect(response).to have_http_status(302)
    end
  end
end
