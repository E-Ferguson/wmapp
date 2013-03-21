class WorkerSessionsController < ApplicationController
  def new
  end

  def create
    worker = Worker.authenticate(params[:email], params[:password])
    if worker
      cookies[:current_worker] = worker.email
      flash[:success] = "You are now logged in."
      redirect_to root_url
    else
      flash.now[:error] = "Couldn't find a worker with those credentials."
      render :action => 'new'
    end
  end

  def destroy
    cookies.delete :current_worker
    flash[:success] = "You have been signed out."
    redirect_to root_url
  end
end
