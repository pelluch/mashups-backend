class Mashup::SourcesController < ApplicationController
  skip_before_action  :authenticate
  respond_to :json


  # GET /mashups
  # GET /mashups.json
  def index
    @sources = LinkSource.all

    respond_to do |format|
      format.json { render json: @sources }
    end
  end

  
  
end
