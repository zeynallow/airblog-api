class CommentSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes  :id, :comment, :created_at,:updated_at
end
