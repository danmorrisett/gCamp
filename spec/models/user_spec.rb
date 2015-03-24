require "rails_helper"

describe User do
  it "requires first name" do
    user = User.new(last_name: "M", email: "DM@gmail.com", password: '123')
    expect(user.valid?).to eq(false)
  end
end
