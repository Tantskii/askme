class HashtagQuestion < ApplicationRecord
  belongs_to :hashtag
  belongs_to :question

  validates :question_id, uniqueness: {scope: :hashtag_id}
end
