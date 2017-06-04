module HashtagsHelper
  def used_hashtags(question)
    question.hashtags.map do |hashtag|
      link_to("##{hashtag.name}", hashtag_path(hashtag),
              html_options = {class: 'hashtag'})
    end.join(' ').html_safe
  end
end
