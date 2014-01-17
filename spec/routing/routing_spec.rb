require 'spec_helper'
describe 'Routing' do
  it 'GET /sign_in to sessions#sign_in' do
    expect(get: '/sign_in').to route_to(controller: 'sessions', action: 'sign_in')
  end

  it 'GET /authorize to sessions#authorize' do
    expect(get: '/authorize').to route_to(controller: 'sessions', action: 'authorize')
  end

  it 'GET /setting to users#setting' do
    expect(get: '/setting').to route_to(controller: 'users', action: 'setting')
  end

  it 'GET /not_found to application#render_404' do
    expect(get: 'not_found').to route_to(controller: 'application', action: 'render_404')
  end
end
