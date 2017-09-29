class PartsController < ApplicationController
  before_action :load_job,:set_part, only: [:show, :edit, :update, :destroy]

  # GET /parts
  # GET /parts.json
  def index
    @parts = Part.preload(:job)
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
    @job = Job.find(params[:job_id])
    @part = @job.parts.find(params[:id])

    respond_to do |format|
      format.html
      format.json {render json: @part}
    end
  end

  # GET /parts/new
  def new
    @job = Job.find(params[:job_id])
    @part = @job.parts.build

    respond_to do |format|
      format.html
      format.json {render json: @part}
    end
  end

  # GET /parts/1/edit
  def edit
    @job = Job.find(params[:job_id])
    @part = @job.parts.find(params[:id])
  end

  # POST /parts
  # POST /parts.json
  def create
    @job = Job.find(params[:job_id])
    @part = @job.parts.build(part_params)

    respond_to do |format|
      if @part.save
        format.html { redirect_to edit_job_path(@job), notice: 'Part was successfully created.' }
        format.json { render json: @job, action:edit, status: :created, location: @part }
      else
        format.html { render :new }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parts/1
  # PATCH/PUT /parts/1.json
  def update
    @job = Job.find(params[:job_id])
    @part = @job.parts.find(params[:id])

    respond_to do |format|
      if @part.update(part_params)
        format.html { redirect_to edit_job_path(@job.id), notice: 'Part was successfully updated.' }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render edit_job_part_path(@job) }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @job = Job.find(params[:job_id])
    @part = @job.parts.find(params[:id])
    @part.destroy
    respond_to do |format|
      format.html { redirect_to edit_job_path(@job), notice: 'Part was successfully destroyed.' }
      format.json { head :ok }
    end
  end

  def finish
    @job = Job.find(params[:job_id])
    @part = @job.parts.find(params[:id])
    @part.update_attribute(:finished, true)

    respond_to do |format|
      format.js {render inline: 'location.reload();'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_job
      @job = Job.find(params[:job_id])
    end

    def set_part
      @part = Part.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_params
      params.require(:part).permit(:partNum, :description, :quantity, :totalQuantity, :workOrder, :finish, :job_id, :item_num)
    end
end
