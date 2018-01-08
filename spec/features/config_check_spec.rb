require 'rails_helper'

RSpec.describe 'Config Check' do
  before do
    allow(ENV).to receive(:[]).with('FIDOR_API_CALLBACK').and_return('undefined')
    allow(ENV).to receive(:[]).and_call_original
  end

  it 'renders a page showing the missing configuration' do
    visit '/'

    expect(page).to have_text 'Incomplete Configuration detected'
    expect(page).to have_text 'FIDOR_API_CALLBACK undefined'
  end
end
