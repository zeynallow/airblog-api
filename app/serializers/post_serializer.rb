class PostSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :title, :content, :created_at,:updated_at
end
