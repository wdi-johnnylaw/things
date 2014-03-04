json.extract! opinion, :rating, :comment
json.url(opinion.persisted? ? opinion_url(opinion, format: 'json') : opinions_url(format: 'json'))
json.is_new opinion.new_record?

json.thing do |json|
  json.extract! opinion.thing, :id, :average_rating
end
