json.array!(@notes) do |note|
  json.extract! note, :title
  json.url note_url(note, format: :json)
end
