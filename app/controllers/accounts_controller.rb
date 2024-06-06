class AccountsController < ApplicationController

  # GET /accounts
  def index
    @accounts = Account.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    if account_exists? 
      render json: @account  
    else
      handle_no_account
    end

  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if account_exists?
      if @account.update(account_params)
        render json: @account
      else
        render json: @account.errors, status: :unprocessable_entity
      end
    else
      handle_no_account
    end
  end

  # DELETE /accounts/1
  def destroy
    if account_exists?
      @account.destroy!
    else
      handle_no_account
    end
  end

  # custom action to fetch users of a given account
  # GET /accounts/1/users
  def users
    if account_exists?
      render json: @account.users
    else
      handle_no_account
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :email, :address)
    end

    def handle_no_account
      render json: {error: "Account not found"}, status: :not_found
    end

    def account_exists?
      begin
        @account = Account.find(params[:id])  
        @account != nil
      rescue ActiveRecord::RecordNotFound
        false
      end
    end
end
