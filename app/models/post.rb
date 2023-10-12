class Post < ApplicationRecord
  #paginates_per 1

  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true


end
