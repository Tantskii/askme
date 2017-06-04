class HashtagsController < ApplicationController
  before_action :load_hashtag, only: [:show]

  # GET /hashtags/1
  def show
    @questions = Hashtag.find_by_name(@hashtag.name).questions
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_hashtag
      @hashtag = Hashtag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hashtag_params
      params.require(:hashtag).permit(:name)
    end
end
