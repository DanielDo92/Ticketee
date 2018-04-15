class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: [:edit, :show, :update, :destroy]

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user
    if @ticket.save
      flash[:notice] = "Ticket has been created"
      redirect_to [@project, @ticket]
    else
      flash.now[:alert]= "Ticket has not been created"
      render "new"
    end
  end

  def edit
  end

  def show
  end

  def update
    if @ticket.update(ticket_params)
      flash[:success] = "Ticket has been updated"
      redirect_to [@project, @ticket]
    else
      flash.now[:alert] = "Ticket has not been updated"
      render "new"
    end
  end

  def destroy
    @ticket.destroy
    flash[:notice] = "Ticket has been deleted"
    redirect_to project_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :description)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
