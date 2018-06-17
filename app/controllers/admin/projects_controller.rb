class Admin::ProjectsController < Admin::ApplicationController
  def new
    @project = Project.new(description: "A project is a project")
    @project.tickets.build(name: "This is a new ticket", description: "A ticket is a ticket")
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = "Project has been created"
      redirect_to @project
    else
      flash.now[:alert]= "Project has not been created"
      render "new"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    flash[:notice] = "Project has been deleted"
    redirect_to @project
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
