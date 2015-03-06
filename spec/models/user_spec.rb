require "rails_helper"

describe User do
  it "requires  first name" do
    user = User.create(first_name: "Dan", last_name: "M", email: "DM@gmail.com", password: '123')
    expect(user).to be_valid
  end
end
