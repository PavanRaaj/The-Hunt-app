class ManagerController < ApplicationController
  before_action :ensure_manager_logged_in
  
  @@arrayofids_to_del = []
  def index
  end

  

  def ensure_manager_logged_in
    redirect_to root_path unless current_user.role == 'Manager'
  end

  def show
    @job = Job.new
    @jobs = Job.where(users_id: current_user.id)
    @array_returned = arrayofids_to_del_returner
    render 'manager/add_jobs'
  end



  def add_job
    jobs = Job.new(job_list_params)
    jobs.users_id = current_user.id
    if jobs.save
      redirect_to manager_job_path 
    end
end

def delete_job
  @delete = Job.find(params[:id])
  if @delete.destroy
  redirect_to manager_job_path
  end
end

def bulk_delete
  arrayofids_to_del_returner.each do |id|
    job_record = Job.find(id)
    job_record.destroy
  end
  @@arrayofids_to_del = []
  redirect_to manager_job_path
end

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

def applicants
  @filtered_applications_array = []
  ApplicantsDetail.all.each do |application|
    job_applied_details = Job.find(application.jobs_id)
    if current_user.id == job_applied_details.users_id
      @filtered_applications_array << application
    end
  end
  # puts ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;"
  # puts @filtered_applications_array
end


  private

  def job_list_params
    params.require(:job).permit(:manager_name, :eligibility, :job_tittle, :about_job, :company_name, :country)
  end
end
