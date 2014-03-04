json.thing do |json|
  json.extract! @thing, :id, :name, :description, :average_rating
  json.image_url asset_url(@thing.image_url)

  json.opinions do |json|
    json.array! @thing.opinions do |opinion|
      json.extract! opinion, :id, :rating, :comment, :created_at
      json.username opinion.user.username
    end
  end

  opinion = @thing.opinions.find_by(user_id: current_user.id) || Opinion.new(thing: @thing, user: current_user)
  json.current_user_opinion do |json|
    json.partial! opinion
  end
end

json.partial! 'shared/messages'