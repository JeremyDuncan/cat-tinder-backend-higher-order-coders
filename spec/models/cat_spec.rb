require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should validate name" do
    cat = Cat.create
    expect(cat.errors[:name]).to_not be_empty
  end

  it "should validate age" do
    cat = Cat.create
    expect(cat.errors[:age]).to_not be_empty
  end

  it "should validate enjoys" do
    cat = Cat.create
    expect(cat.errors[:enjoys]).to_not be_empty
  end

  it "should validate image" do
    cat = Cat.create
    expect(cat.errors[:image]).to_not be_empty
  end

  it "should validate enjoys length is greater than 10" do
    #CREATE
    cat =  Cat.create(
        id: 1,
        name: 'Stella',
        age: 12,
        enjoys: 'staring',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

    expect(cat.errors[:enjoys]).to_not be_empty
  end

end
