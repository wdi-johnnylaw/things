json.extract! opinion, :id, :rating, :comment, :created_at
json.username opinion.user.username
json.url(opinion.persisted? ? opinion_url(opinion, format: 'json') : opinions_url(format: 'json'))
json.is_new opinion.new_record?

json.thing do |json|
  json.extract! opinion.thing, :id, :average_rating
end
