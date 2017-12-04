class JobsController < ApplicationController
  before_action :load_parts, :set_job, only: [:show, :edit, :update, :destroy]

  # GET /jobs
  # GET /jobs.json
  def index
    if params[:finished] == nil or params[:finished] == 'false'
      @jobs = Job.where('finished = ?', false).preload(:parts)
    else
      @jobs = Job.where('finished = ?', true).preload(:parts)
    end

    respond_to do |format|
      format.html {render 'index'}
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save&&@job.work_type.exclude?('Pump')
        format.html { redirect_to jobs_path, notice: 'Job was successfully created.' }
        format.json { render @job, status: :created, location: @job }
      elsif @job.save&&@job.work_type.include?('Pump')
        format.html { redirect_to new_job_pump_path(@job.id), notice: 'Job was successfully created.' }
        format.json { render @job, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to jobs_path, notice: 'Job was successfully updated.' }
        format.json { render :index, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sort
    @jobs = Job.all.preload(:parts)
    old_priority = params[:oldPriority].to_i+1
    new_priority = params[:newPriority].to_i+1
    @job = Job.find_by_priority(old_priority)
    @job.update_attribute(:priority, new_priority)

    respond_to do |format|
      format.js {render inline: 'location.reload();'}
    end
  end

  def finish
    @jobs = Job.order(:priority)
    @job = Job.find(params[:id])
    @job.update_attribute(:finished, true)
    @job.update_attribute(:priority, @jobs.last.priority)
    @job.parts.update_all(finished: true)

    respond_to do |format|
      format.js {render inline: 'location.reload();'}
    end
  end

  def activate
    @jobs = Job.order(:priority)
    @job = Job.find(params[:id])
    @job.update_attribute(:finished, false)
    @job.update_attribute(:priority, @job.priority_was)
    @job.parts.update_all(finished: false)

    respond_to do |format|
      format.js {render inline: 'location.reload();'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    def load_parts
      @parts = Part.where('job_id = ?', params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:jobNum, :poDate, :customer, :description, :needBom, :bomDone, :status, :progress, :priority, :finished, :dueDate, :work_type)
    end
end
