json.array!(@answers) do |answer|
  json.extract! answer, :id, :question_id, :body
  json.url answer_url(answer, format: :json)
end
