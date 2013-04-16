class UploadsController < ApplicationController
  def create
    incoming_file = params[:file]
    File.open(Rails.root.join('public', 'uploads', incoming_file.original_filename), 'wb') do |file|
      file.write(incoming_file.read)
    end    
    respond_to do |format|
      format.json { render json: {ok: true} }
    end
  end
end
