class ReportsController < ApplicationController
  def index
    @jobs = Job.all
    @sel_job = {}
    @sel_job = params[:sel_jobNum]
    respond_to do |format|
      format.html {render 'jobs/reports'}
    end
  end

  def active_jobs
    @jobs = Job.where('finished = ?', false)
    respond_to do |format|
      format.html {render 'jobs/reports'}
      format.pdf do
        pdf = ReportPdf.new(@jobs)
        send_data pdf.render,
                  filename: 'Active_Jobs_Report.pdf',
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  def finished_jobs
    @jobs = Job.where('finished = ?', true)
    respond_to do |format|
      format.html {render 'jobs/reports'}
      format.pdf do
        pdf = ReportPdf.new(@jobs)
        send_data pdf.render,
                  filename: 'Active_Jobs_Report.pdf',
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  def job_summary
    @job = Job.find_by_jobNum(params[:jobNum])
    respond_to do |format|
      format.pdf do
        pdf = SingleJobReportPdf.new(@job)
        send_data pdf.render,
                  filename: 'Job_Report.pdf',
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  def bill_of_materials
    @job = Job.find_by_jobNum(params[:jobNum])
    respond_to do |format|
      format.pdf do
        pdf = JobBomPdf.new(@job)
        send_data pdf.render,
                  filename: 'Job_Report.pdf',
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  def show
    @job = Job.find_by_jobNum(params[:jobNum])
  end
end