class SemanasController < ApplicationController
  before_action :set_semana, only: [:show, :edit, :update, :destroy]

  # GET /semanas
  # GET /semanas.json
  def index
    @semanas = Semana.all
  end

  # GET /semanas/1
  # GET /semanas/1.json
  def show
  end

  # GET /semanas/new
  def new
    @semana = Semana.new
  end

  # GET /semanas/1/edit
  def edit
  end

  # POST /semanas
  # POST /semanas.json
  def create
    @semana = Semana.new

    respond_to do |format|
      if @semana.save
        format.html { redirect_to @semana, notice: 'Semana was successfully created.' }
        format.json { render :show, status: :created, location: @semana }
      else
        format.html { render :new }
        format.json { render json: @semana.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /semanas/1
  # PATCH/PUT /semanas/1.json
  def update
    respond_to do |format|
      if @semana.update(semana_params)
        format.html { redirect_to @semana, notice: 'Semana was successfully updated.' }
        format.json { render :show, status: :ok, location: @semana }
      else
        format.html { render :edit }
        format.json { render json: @semana.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /semanas/1
  # DELETE /semanas/1.json
  def destroy
    @semana.destroy
    respond_to do |format|
      format.html { redirect_to semanas_url, notice: 'Semana was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_semana
      @semana = Semana.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  #  def semana_params
  #    params.require(:semana).permit(:viaje_recurrente).merge(viaje: ViajeRecurrente.find(params[:semana][:viaje_recurrente]))
  #  end
end
