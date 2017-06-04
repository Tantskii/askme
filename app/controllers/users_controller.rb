class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :create, :new, :show]

  def index
    @users    = User.all
    @hashtags = Hashtag.all

    @hashtags_first  = []
    @hashtags_second = []
    @hashtags_third  = []

    devide_into_three(@hashtags)
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогиены' if current_user.present?

    @user = User.new
  end

  def edit
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогиены' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id

      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def update
    if user_params[:password] == ''
      params_for_update = user_params_with_out_password
    else
      params_for_update = user_params
    end

    if @user.update(params_for_update)
      redirect_to user_path(@user), notice: 'Данные обновлены!'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count  = @questions.count
    @answers_count    = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    username = @user.username

    session[:user_id] = nil
    @user.destroy

    redirect_to root_url, notice: "Профиль @#{username} успешно удален"
  end

  private

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :color)
  end

  def user_params_with_out_password
    params.require(:user).permit(:email, :name, :username, :avatar_url, :color)
  end

  def authorize_user
    reject_user unless @user == current_user
  end

  def devide_into_three(hashtags)
    hashtags.each_with_index do |hashtag, index|
      case
      when index % 3 == 0
        @hashtags_first << hashtag
      when index % 3 == 1
        @hashtags_second << hashtag
      when index % 3 == 2
        @hashtags_third << hashtag
      end
    end
  end
end