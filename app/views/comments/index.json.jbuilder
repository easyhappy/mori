json.array!(@comments) do |comment|
  json.extract! comment, :user_id, :book_id, :content
  json.url comment_url(comment, format: :json)
end
