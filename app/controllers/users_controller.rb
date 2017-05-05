class UsersController < ApplicationController
  def index
    @users = [
        User.new(
          id: 1,
          name: 'Tihon',
          username: 'tantskii',
          avatar_url: 'mable.png'
        ),
        User.new(
          id: 2,
          name: 'Pablo',
          username: 'brtbds',
        ),
        User.new(
          id: '3',
          name: 'Ilya',
          username: 'oldflanigan',
          avatar_url: 'soos.png'
        )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
        name: 'Tihon',
        username: 'tantskii',
        avatar_url: 'mable.png'
    )

    @questions = [
        Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016'))
    ]

    @new_question = Question.new
  end
end
