json.array!(@topics) do |topic|
  json.extract! topic, :id, :name, :url
  json.url topic_url(topic, format: :json)
end
