class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: "Вы уже залогинены" if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: "Вы уже залогинены" if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Пользователь успешно зарегестрирован!"
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Данные обновлены"
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    @user.questions.each { |question| question.destroy }
    @user.destroy
    redirect_to root_url, notice: "Пользователь удален"
  end

  def show
    @head = @user.head
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions.size - @answers_count
  end

  private
  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url, :head)
  end
end
