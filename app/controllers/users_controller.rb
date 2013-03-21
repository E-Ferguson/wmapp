class UsersController < ApplicationController
  def new
    @user = User.new
    @grad_years = grad_years
    @dorms = dorms
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Your account has been successfully created!"
      self.current_user = @user
      redirect_to @user
    else
      @grad_years = grad_years
      @dorms = dorms
      render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def grad_years
    [2013, 2014, 2015, 2016]
  end

  def dorms
    %w(Dinwiddie Stith Yates Monroe)
  end
end
