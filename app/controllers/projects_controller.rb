class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :update, :edit]
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
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

  def show
  end

  def edit
  end

  def update
    @count = 1
    if @project.update(project_params)
      flash[:notice] = "Project has been updated"
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been updated"
      render 'new'
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
