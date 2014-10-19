class Mashup::MashupsController < ApplicationController
  # before_action :set_mashup, only: [:destroy]

  # GET /mashups
  # GET /mashups.json
  def index
    @mashups = @user.mashups

    respond_to do |format|
      format.json { render json: @mashups }
    end
  end

  # GET /mashups/1
  # GET /mashups/1.json
  def show
    @mashup = Mashup.find(params[:id])    
    #@mashup.as_json(include: :keywords)
    respond_to do |format|
      format.json { render json: @mashup }
    end
  end

  # POST /mashups
  # POST /mashups.json
  def create
    @mashup = @user.temporal.clone

    respond_to do |format|
      if @mashup.save
        format.json { render json: @mashup, status: :created }
      else
        format.json { render json: @mashup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mashups/1
  # PATCH/PUT /mashups/1.json
  def update

    respond_to do |format|
      if @user.temporal.update(mashup_params)
        format.json { render jason: @user.temporal }
      else
        format.json { render json: @user.temporal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mashups/1
  # DELETE /mashups/1.json
  def destroy
    @user.mashup.find(params[:id])
    
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
      # Use callbacks to share common setup or constraints between actions.
      # def set_mashup
      #   @mashup = Mashup.find(params[:id])
      # end

      # Never trust parameters from the scary internet, only allow the white list through.
    def mashup_params
      params.require(:mashup).permit(:parameters)
    end
  
end
