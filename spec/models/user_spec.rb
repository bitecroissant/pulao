require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has email' do
    user = User.new email: 'xxx@yyy.cc'
    expect(user.email).to eq 'xxx@yyy.cc'
  end
end
