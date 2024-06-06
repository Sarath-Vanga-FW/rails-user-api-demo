class UsersController < ApplicationController
  before_action :check_account, except: [:index, :show, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    if user_exists?
      render json: @user
    else
      handle_no_user
    end
  end

  # POST /users
  def create
    account_id = params[:account_id]
    @account = Account.find(account_id)
    @user = @account.users.create(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if user_exists?
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      handle_no_user
    end
  end

  # DELETE /users/1
  def destroy
    if user_exists?
      @user.destroy!
    else
      handle_no_user
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def user_exists?
      # find_by methods doesn't raise the RecordNotFound exception.
      begin
        @user = User.find(params[:id])
        @user != nil
      rescue ActiveRecord::RecordNotFound
        return false
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :role, :account_id)
    end

    def handle_no_user
      render json: {error: "User not found"}, status: :not_found
    end

    def check_account
      account_id = params[:account_id]
      begin
        @account = Account.find(account_id)
      rescue ActiveRecord::RecordNotFound
        render json: {error: "Account not found"}, status: :not_found
      end
    end
end
