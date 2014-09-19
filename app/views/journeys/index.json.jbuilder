json.array!(@journeys) do |journey|
  json.extract! journey, :id, :title, :body
  json.url journey_url(journey, format: :json)
end
