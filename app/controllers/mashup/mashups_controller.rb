class Mashup::MashupsController < ApplicationController
  # before_action :set_mashup, only: [:destroy]
  skip_before_action  :authenticate, only: [:index_total, :index, :show]
  before_action       :get_user, only: [:index]
  respond_to :json

  # GET /mashups
  # GET /mashups.json
  def index_total
    @mashups = Mashup.where.not(name: 'temporal')

    respond_to do |format|
      format.json { render json: @mashups.as_json(include: {:keywords => {}, :links => {include: {:link_source => {}}} })}
    end
  end


  # GET /mashups
  # GET /mashups.json
  def index
    @mashups = @user.mashups
    respond_to do |format|
      format.json { render json: @mashups.as_json(include: {:keywords => {}, :links => {include: {:link_source => {}}} })}
    end
  end

  # GET /mashups/1
  # GET /mashups/1.json
  def show
    @mashup = Mashup.find(params[:id])    
    
    # if params[:user_id] || params[:login]
    #   authenticate
    #   if @user.temporal.id != @mashup.id        
    #     @user.regenerate_temporal @mashup
    #     @user.save
    #   end
    # end 
    respond_to do |format|
      format.json { render json: @mashup.as_json(include: {:keywords => {}, :links => {include: {:link_source => {}}} })}
      #format.json { render json: @mashup }
    end
  end

  def new
    @user.reset_temporal
    @user.save
    respond_to do |format|
      #format.json { render json: @user.temporal.as_json }
      format.json { render json: @user.temporal.as_json(include: {:keywords => {}, :links => {include: {:link_source => {}}} }) }
    end
  end

  # POST /mashups
  # POST /mashups.json
  def create
    @mashup = @user.temporal
    @mashup.name = params[:name]
    @user.mashups << @mashup

    @user.generate

    respond_to do |format|
      if @mashup.save
        format.json { render json: @mashup.as_json(include: {:keywords => {}, :links => {include: {:link_source => {}}} }) }
      else
        format.json { render json: @mashup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mashups/
  def update
    @user.reset_temporal
    @user.save
    unless params.has_key? :parameters
       params[:parameters] = []
    else
     
      
      m = @user.temporal

      parametros = Array.new
      params[:parameters].each do |p|
        parametros << p
      end

      #if params.has_key? :sources
        sources = params[:sources]
        
      #   sources.delete_if { |a| a == "" } 
      # else
      #   sources = ['twitter', 'emol']
      # end
      
      m.generate(parametros, sources) if parametros.count > 0
      
      m.update(parameters: parametros)
      m.save
      
    end
      respond_to do |format|
        format.json { render json: @user.temporal.as_json(include: {:keywords => {}, :links => {include: {:link_source => {}}} }) }     
      end
  end

  # DELETE /mashups/1
  # DELETE /mashups/1.json
  def destroy
    mashup = @user.mashups.find(params[:id])
    unless mashup.name == 'temporal'
      mashup.destroy
    end
    respond_to do |format|
      format.json { render json: @user }
    end
  end

  private
      # Use callbacks to share common setup or constraints between actions.
      # def set_mashup
      #   @mashup = Mashup.find(params[:id])
      # end

      # Never trust parameters from the scary internet, only allow the white list through.
    def mashup_params
      params.require(:mashup).permit(:parameters, :name)
    end
  
end
