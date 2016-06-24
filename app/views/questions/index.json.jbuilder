json.array!(@questions) do |question|
  json.extract! question, :id, :body, :user_id, :type
  json.url question_url(question, format: :json)
end
