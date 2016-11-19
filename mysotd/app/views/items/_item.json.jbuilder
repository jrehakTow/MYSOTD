json.extract! item, :id, :name, :description, :uses, :price, :purchaseDate, :retired, :category_id, :user_id, :created_at, :updated_at
json.url item_url(item, format: :json)