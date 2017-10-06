class ReportsController < ApplicationController
  def index
    @jobs = Job.all
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
  end

  def bill_of_materials
  end
end