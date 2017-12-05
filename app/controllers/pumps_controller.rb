class PumpsController < ApplicationController
  before_action :set_job, :set_pump, only: [:show, :edit, :update, :destroy]

  # GET /pumps
  # GET /pumps.json
  def index
    @pumps = Pump.preload(:job)
  end

  # GET /pumps/1
  # GET /pumps/1.json
  def show
    @job = Job.find(params[:job_id])
    @pump = @job.pumps.find(params[:id])
  end

  # GET /pumps/new
  def new
    @job = Job.find(params[:job_id])
    @pump = @job.pumps.build
  end

  # GET /pumps/1/edit
  def edit
    @job = Job.find(params[:job_id])
    @pump = @job.pumps.find(params[:id])
  end

  # POST /pumps
  # POST /pumps.json
  def create
    @job = Job.find(params[:job_id])
    @pump = @job.pumps.build(pump_params)

    respond_to do |format|
      if @pump.save
        format.html { redirect_to job_pump_path(@job.id, @pump.id), notice: 'Pump was successfully created.' }
        format.json { render :show, status: :created, location: @pump }
      else
        format.html { render :new }
        format.json { render json: @pump.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pumps/1
  # PATCH/PUT /pumps/1.json
  def update
    @job = Job.find(params[:job_id])
    @pump = @job.pumps.find(params[:id])

    respond_to do |format|
      if @pump.update(pump_params)
        format.html { redirect_to job_pump_path(@job.id, @pump.id), notice: 'Pump was successfully updated.' }
        format.json { render :show, status: :ok, location: @pump }
      else
        format.html { render :edit }
        format.json { render json: @pump.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pumps/1
  # DELETE /pumps/1.json
  def destroy
    @pump = Pump.find_by job_id: @job.id, id: params[:id]

    @pump.destroy

    respond_to do |format|
      format.html { redirect_to edit_job_path(@job), notice: 'Pump was successfully destroyed.' }
      format.json { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @pump = Pump.find(params[:id])
      @job = Job.find(@pump.job_id)
    end
    def set_pump
      @pump = Pump.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pump_params
      params.require(:pump).permit(:product_type, :stages, :flowrate, :dev_head, :assembly, :restrictions, :quantity, :job_id, :item_num)
    end
end
