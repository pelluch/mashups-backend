module Mashup
  class MashupsController < ApplicationController
    before_action :set_mashup, only: [:show, :edit, :update, :destroy]

    # GET /mashups
    # GET /mashups.json
    def index
      @mashups = Mashup.all

      respond_to do |format|      
        format.json { render json: @mashups }
      end
    end

    # GET /mashups/1
    # GET /mashups/1.json
    def show
      respond_to do |format|      
        format.json { render json: @mashup }
      end
    end

    # GET /mashups/new
    def new
      @mashup = Mashup.new
    end

    # GET /mashups/1/edit
    def edit
    end

    # POST /mashups
    # POST /mashups.json
    def create
      @mashup = Mashup.new(mashup_params)
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
        if @mashup.update(mashup_params)        
          format.json { head :no_content }
        else        
          format.json { render json: @mashup.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /mashups/1
    # DELETE /mashups/1.json
    def destroy
      @mashup.destroy
      respond_to do |format|
        format.html { redirect_to mashups_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_mashup
        @mashup = Mashup.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def mashup_params
        params.require(:mashup).permit(:parameters)
      end
  end
end