json.set! :posts do
  json.array! @posts, :id, :content, :created_at
end
