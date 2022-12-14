class ManagerController < ApplicationController
  before_action :ensure_manager_logged_in
  
  @@arrayofids_to_del = []
  def index
  end

  
  # to ensure only manager enter nto manager portal
  def ensure_manager_logged_in
    redirect_to root_path unless current_user.role == 'Manager'
  end


  def show
    @job = Job.new
    @jobs = Job.where(users_id: current_user.id)
    @array_returned = arrayofids_to_del_returner
    render 'manager/add_jobs'
  end


# method used to add jobs by manager
  def add_job
    jobs = Job.new(job_list_params)
    jobs.users_id = current_user.id
    if jobs.save
      redirect_to manager_job_path 
    end
end

# method to delete a particular job
def delete_job
  @delete = Job.find(params[:id])
  if @delete.destroy
  redirect_to manager_job_path
  end
end

# deleting ids stored in array
def bulk_delete
  arrayofids_to_del_returner.each do |id|
    job_record = Job.find(id)
    job_record.destroy
  end
  @@arrayofids_to_del = []
  redirect_to manager_job_path
end

# add ids of selected jobs in array
def bulk_delete_add
  if params[:selected][:result].to_i == 1
  @@arrayofids_to_del << params[:job_id]
  else
    @@arrayofids_to_del.delete(params[:job_id])
  end
  redirect_to manager_job_path
end

def arrayofids_to_del_returner
  @@arrayofids_to_del
end

# method used to view the applicants of their jobs
def applicants
  @filtered_applications_array = []
  ApplicantsDetail.all.each do |application|
    job_applied_details = Job.find(application.jobs_id)
    if current_user.id == job_applied_details.users_id
      @filtered_applications_array << application
    end
  end
end

def edit
  @job = Job.find(params[:id])
  render :edit
end

def update
  @job = Job.find(params[:id])
  if @job.update(params.require(:job).permit(:manager_name, :eligibility, :job_tittle, :about_job, :company_name, :country))
    redirect_to manager_job_path
  else
    render :edit
  end
end
  private
  
  def job_list_params
    params.require(:job).permit(:manager_name, :eligibility, :job_tittle, :about_job, :company_name, :country)
  end
end
