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
          name: 'Garfeild',
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
       expect(cat.name).to eq 'Garfeild'
    end
  end

  describe "DELETE /destroy" do
    it "Destroys a cat" do

      #CREATE
      Cat.create(
        id: 1,
        name: 'Stella',
        age: 12,
        enjoys: 'Pushing glasses off tables',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

       # Send a request to server
       delete cat_path(1)
       
       
       # Assure we get good code back
       expect(response).to have_http_status(200)
    end
  end

  describe "API Validations" do
    it "Doesn't create a cat without a name" do
    cat_params = { 
      cat: { 
        age: 2,
        enjoys: 'bossing the dog around',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
       }
     }

     # Send request to the server
     post '/cats', params: cat_params

     # Expect an error if the cat_params does not have a name
     expect(response.status).to eq 422

     # Convert JSON response into a Ruby Hash
     json = JSON.parse(response.body)

     # Errors are returned as an array because there could be more than one,
     # if there are more than one validation failures on an attribute.
     expect(json['name']).to include "can't be blank"
    end

    it "Doesn't create a cat without a age" do
      cat_params = { 
        cat: { 
          name: 'furry',
          enjoys: 'bossing the dog around',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
         }
       }
  
       # Send request to the server
       post '/cats', params: cat_params
  
       # Expect an error if the cat_params does not have a name
       expect(response.status).to eq 422
  
       # Convert JSON response into a Ruby Hash
       json = JSON.parse(response.body)
  
       # Errors are returned as an array because there could be more than one,
       # if there are more than one validation failures on an attribute.
       expect(json['age']).to include "can't be blank"
      end

    it "Doesn't create a cat without an enjoys" do
      cat_params = { 
        cat: { 
          name: 'furry',
          age: 2,
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
          }
        }
  
        # Send request to the server
        post '/cats', params: cat_params
  
        # Expect an error if the cat_params does not have a name
        expect(response.status).to eq 422
  
        # Convert JSON response into a Ruby Hash
        json = JSON.parse(response.body)
  
        # Errors are returned as an array because there could be more than one,
        # if there are more than one validation failures on an attribute.
        expect(json['enjoys']).to include "can't be blank"
      end

    it "Doesn't create a cat without an image" do
      cat_params = { 
        cat: { 
          name: 'furry',
          age: 2,
          enjoys: 'attacking it\'s tail'
          }
        }
  
        # Send request to the server
        post '/cats', params: cat_params
  
        # Expect an error if the cat_params does not have a name
        expect(response.status).to eq 422
  
        # Convert JSON response into a Ruby Hash
        json = JSON.parse(response.body)
  
        # Errors are returned as an array because there could be more than one,
        # if there are more than one validation failures on an attribute.
        expect(json['image']).to include "can't be blank"
      end    

      it "Validates correct update of enjoys length" do

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
            name: "Garfeild",
            age: 40,
            enjoys: 'Eating',
            image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
          }
         })

  
        # Expect an error if the cat_params does not have correct enjoys length
        expect(response.status).to eq 422
  
        # Convert JSON response into a Ruby Hash
        json = JSON.parse(response.body)
  
        # Errors are returned as an array because there could be more than one,
        # if there are more than one validation failures on an attribute.
        expect(json['enjoys']).to include "is too short (minimum is 10 characters)"
      end  

    it "Validates correct update of name presence" do

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
          name: "",
          age: 40,
          enjoys: 'Eating',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
        })


      # Expect an error if the cat_params does not have a name
      expect(response.status).to eq 422

      # Convert JSON response into a Ruby Hash
      json = JSON.parse(response.body)

      # Errors are returned as an array because there could be more than one,
      # if there are more than one validation failures on an attribute.
      expect(json['name']).to include "can't be blank"
    end  

    it "Validates correct update of age presence" do

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
          name: "Garfeild",
          age: nil,
          enjoys: 'Eating',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
        })


      # Expect an error if the cat_params does not have an age
      expect(response.status).to eq 422

      # Convert JSON response into a Ruby Hash
      json = JSON.parse(response.body)

      # Errors are returned as an array because there could be more than one,
      # if there are more than one validation failures on an attribute.
      expect(json['age']).to include "can't be blank"
    end 

    it "Validates correct update of image presence" do

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
          name: "Garfeild",
          age: 11,
          enjoys: 'Eating',
          image: ''
        }
        })


      # Expect an error if the cat_params does not have a image
      expect(response.status).to eq 422

      # Convert JSON response into a Ruby Hash
      json = JSON.parse(response.body)

      # Errors are returned as an array because there could be more than one,
      # if there are more than one validation failures on an attribute.
      expect(json['image']).to include "can't be blank"
    end  
  end


end
