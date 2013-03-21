class WorkersController < ApplicationController

  def create
    @worker = Worker.new(params[:worker])
    if @worker.save
      flash[:success] = "Your account has been successfully created!"
      self.current_worker = @worker
      redirect_to @worker
    else
      @grad_years = grad_years
      @dorms = dorms
      render :action => 'new'
    end
  end

  def show
    @worker = Worker.find(params[:id])
  end

end
