require 'rails_helper'

RSpec.describe Yumyum::TopController, type: :request do
  describe "index_controller" do

    before do
      get yumyum_root_path
    end
    it "ページが表示されるか" do
      expect(response).to have_http_status(200)
    end

  end
end
