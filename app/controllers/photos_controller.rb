class PhotosController < ApplicationController
  before_filter :authenticate_user!, :only => [:destroy]
  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    album = @photo.album
    @photo.destroy if album.user == current_user

    respond_to do |format|
      format.html { redirect_to(album_path(album)) }
      format.xml  { head :ok }
    end
  end
end
