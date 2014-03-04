json.messages do |json|
  json.notice flash[:notice] if flash[:notice]
  json.alert flash[:alert] if flash[:alert]
end

flash.clear