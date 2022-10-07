class IntervieweeController < ApplicationController
  def index
   @applicant = ApplicantsDetail.all
  end
 
  # This method is used to search jobs from Job model
  def search_job
    @searched_job = Job.where('job_tittle Like ? OR company_name Like ? OR country Like ?' , "%" + params[:q] + "%", "%" + params[:q] + "%", "%" + params[:q] + "%" )
  end

  # This method is to show a particular job on clicking on view button in list page
 def show
  @job = Job.find(params[:id])
 end

def new_applicant
  @applicant = ApplicantsDetail.new
  render 'interviewee/application_form'
end
 
  # This method is to store applicant details in ApplicantsDetail model
def applicants_details
  applicants = ApplicantsDetail.new(applicants_details_params)
  applicants.users_id = current_user.id
  applicants.jobs_id = params[:id]
  if applicants.save
    redirect_to interviwee_path
  else
    render plain: 'fialed'
  end
end

private

def applicants_details_params
  params.require(:applicants_detail).permit(:alternate_mobile_number, :address, :education, :attachment)
end


end
