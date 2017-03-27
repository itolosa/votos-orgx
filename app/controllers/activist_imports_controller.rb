class ActivistImportsController < ApplicationController
  def new
    @activist_import = ActivistImport.new
    authorize ActivistImport
  end

  def create
    @activist_import = ActivistImport.new(params[:activist_import])
    authorize @activist_import
    
    if @activist_import.save
      redirect_to activists_url, notice: "Imported activists successfully."
    else
      render :new
    end
  end
end
