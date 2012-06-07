class ProfileController < ApplicationController
  def show
    @user = {}
    if signed_in? then
      @user[:ot_lg] = LANGUAGE_ABBREVIATIONS[current_user.ot_lg]
      @user[:nt_lg] = LANGUAGE_ABBREVIATIONS[current_user.nt_lg]
    else
      #needs to be factored out
      if session[:nt_lg] == nil then
        session[:nt_lg] = "eng"
      end
      if session[:ot_lg] == nil then
        session[:ot_lg] = "eng"
      end
      @user[:ot_lg] = LANGUAGE_ABBREVIATIONS[session[:ot_lg]]
      @user[:nt_lg] = LANGUAGE_ABBREVIATIONS[session[:nt_lg]]
    end
  end

  def edit
  end
  
  def settings
    @user = {}
    if signed_in? then
      @user[:ot_lg] = current_user.ot_lg
      @user[:nt_lg] = current_user.nt_lg
    else
      #needs to be factored out
      if session[:nt_lg] == nil then
        session[:nt_lg] = "eng"
      end
      if session[:ot_lg] == nil then
        session[:ot_lg] = "eng"
      end
      @user[:ot_lg] = session[:ot_lg]
      @user[:nt_lg] = session[:nt_lg]
    end
  end
  
  def update
    puts params
    if signed_in? then
      if params[:ot_lg] != nil
        current_user.ot_lg = params[:ot_lg]
      end
      if params[:nt_lg] != nil
       current_user.nt_lg = params[:nt_lg] 
      end
       if params[:image] != nil
         uploader = CarrierWave::Uploader::Base::ImageUploader.new
         uploader.store!(params[:image])
      end
       current_user.save
    else
      session[:ot_lg] = params[:ot_lg]
      session[:nt_lg] = params[:nt_lg]
    end
    redirect_to profile_path, :notice => "Settings updated."
  end

end
