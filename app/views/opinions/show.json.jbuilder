json.opinion do |json|
  json.extract! @opinion, :rating, :comment
  json.url opinion_url(@opinion)

  json.thing do |json|
    json.average_rating @opinion.thing.average_rating
  end
end

json.partial! 'shared/messages'