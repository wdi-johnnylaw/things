json.things do |json|       # Gives the root, { things: ...}
  json.array!(@things) do |thing|   # Sets up the array @things, each one in thing
    json.extract! thing, :id, :name  # Prints id and name of each thing
    json.image_url asset_url(thing.image_url)  # Prints :image_url property as full url
    json.url thing_url(thing)   # Prints out url of thing
    json.opinions do |json|    # Creates a property of each thing called 'opinions'
      json.count thing.opinions.count  # Prints out the count of opinions on each thing
    end
  end
end

json.partial! 'shared/messages'
