json.opinion do |json|
  json.partial! @opinion
end

json.partial! 'shared/messages'