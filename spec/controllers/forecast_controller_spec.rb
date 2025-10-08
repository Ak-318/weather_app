require 'rails_helper'

RSpec.describe ForecastsController, type: :controller do
  describe 'GET show' do
    it 'renders show template' do
      get :show
      expect(response).to render_template(:show)
    end
    
    it 'assigns forecast with valid address' do
      get :show, params: { address: 'Visakhapatnam, Andhra Pradesh 530014' }
      expect(assigns(:forecast)).to be_a(Forecast)
    end
    
    it 'handles errors gracefully' do
      allow(Forecast).to receive(:for_address).and_raise(StandardError)
      get :show, params: { address: 'Invalid Address' }
      expect(flash[:alert]).to be_present
    end
  end
end