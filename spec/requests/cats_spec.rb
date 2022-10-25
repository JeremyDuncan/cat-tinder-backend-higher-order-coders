require 'rails_helper'

RSpec.describe "Cats", type: :request do
  # INDEX
  describe "GET /index" do
    it "gets a list of cats" do  
      Cat.create(
        name: 'Stella',
        age: 12,
        enjoys: 'Pushing glasses off tables',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

      # make a request
      get '/cats'

      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end

  #CREATE
  describe "POST /create" do
    it "creates a cat" do
      # Params to send 
      cat_params = { 
        cat: {
        name: 'Garfeild',
        age: 40,
        enjoys: 'Eating lasagna.',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
        # Send a request to server
        post '/cats', params: cat_params

        # Assure we get good code back
        expect(response).to have_http_status(200)

        # Look up the cat we created
        cat = Cat.first

        # Check to see if cat has the same attribute that were given
        expect(cat.name).to eq 'Garfeild'
    end
  end

  describe "UPDATE /patch" do
    it "Updates a cat" do

      #CREATE
      Cat.create(
        id: 1,
        name: 'Stella',
        age: 12,
        enjoys: 'Pushing glasses off tables',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

       # Send a request to server
       patch cat_path(1,   params: {
        cat: {
          id: 1,
          name: 'test',
          age: 40,
          enjoys: 'Eating lasagna.',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
       })
       
       # Assure we get good code back
       expect(response).to have_http_status(200)

       # Look up the cat we created
       cat = Cat.first

       # Check to see if cat has the same attribute that were given
       expect(cat.name).to eq 'test'
    end
  end

end
