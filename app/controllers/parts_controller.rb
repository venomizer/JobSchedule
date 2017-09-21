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
    @job = Job.find(params[:id])
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
    @part = @job.parts.find(params[:id])
  end

  # POST /parts
  # POST /parts.json
  def create
    @part = @job.parts.build(params[:part])

    respond_to do |format|
      if @part.save
        format.html { redirect_to @job, @part, notice: 'Part was successfully created.' }
        format.json { render json: @part, status: :created, location: @part }
      else
        format.html { render :new }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parts/1
  # PATCH/PUT /parts/1.json
  def update
    @part = @job.parts.find(params[:id])

    respond_to do |format|
      if @part.update(part_params)
        format.html { redirect_to @job, @part, notice: 'Part was successfully updated.' }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render :edit }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @part = @job.parts.find(params[:id])
    @part.destroy
    respond_to do |format|
      format.html { redirect_to @job, notice: 'Part was successfully destroyed.' }
      format.json { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def load_job
      @job = Job.find(:params[:job_id])
    end

    def set_part
      @part = @job.parts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_params
      params.require(:part).permit(:partNum, :description, :quanitity, :totalQuantity, :workOrder, :finish, :job_id)
    end
end
