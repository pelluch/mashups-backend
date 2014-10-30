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
    if params[:user_id]
      authenticate
      @user.regenerate_temporal @mashup
      @user.save
    end 
    respond_to do |format|
      format.json { render json: @mashup.as_json(include: {:keywords => {}, :links => {include: {:link_source => {}}} })}
      #format.json { render json: @mashup }
    end
  end

  # POST /mashups
  # POST /mashups.json
  def create
    @mashup = Mashup.clonar @user.temporal
    
    @mashup.name = params[:name]
    @user.mashups << @mashup
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
    m = @user.temporal
    #@user.temporal.generate(params[:parameters])
    m.update(parameters: params[:parameters])

    Link.create(value: 3, link: "#", title: "una noticia", mashup_id: m.id, link_source_id: 1)
    #Link.create(value: 3, link: "#", title: "otra noticia", mashup_id: m.id, link_source_id: 4)
    #Link.create(value: 3, link: "#", title: "alguna noticia", mashup_id: m.id, link_source_id: 2)
    #Link.create(value: 3, link: "#", title: "un post", mashup_id: m.id, link_source_id: 2)
    #Link.create(value: 3, link: "#", title: "otra cosa", mashup_id: m.id, link_source_id: 3)
    @user.temporal = m

    respond_to do |format|
      format.json { render json: @user.temporal.as_json(include: {:keywords => {}, :links => {include: {:link_source => {}}} }) }     
    end
  end

  # DELETE /mashups/1
  # DELETE /mashups/1.json
  def destroy
    mashup = @user.mashups.find(params[:id])
    mashup.destroy

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
      params.require(:mashup).permit(:parameters, :name)
    end
  
end
