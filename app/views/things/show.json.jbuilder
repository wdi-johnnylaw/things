json.thing do |json|
  json.extract! @thing, :id, :name, :description, :average_rating
  json.image_url asset_url(@thing.image_url)

  json.opinions do |json|
    json.array! @thing.opinions do |opinion|
      json.extract! opinion, :rating, :comment, :created_at
      json.username opinion.user.username
    end
  end
end
