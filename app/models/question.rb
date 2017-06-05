class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  has_many :hashtag_questions
  has_many :hashtags, through: :hashtag_questions

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}

  before_save :set_hashtags

  private

  def set_hashtags
    hashtags = (self.text + ' ' + self.answer.to_s).scan(Hashtag::REGEXP)

    self.hashtags.delete_all

    hashtags.each do |hashtag|
      self.hashtags << Hashtag.find_or_create_by(name: hashtag[1..-1])
    end
  end
end
