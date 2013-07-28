Event::Admin.controllers :medias do
  get :index do
    @title = "Media"
    @media = Media.all
    render 'medias/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'media')
    @media = Media.new
    render 'medias/new'
  end

  post :create do
    filename = Media.upload_file(params[:file])
    @media = Media.new(params[:media])
    @media.location = filename

    if @media.location && @media.save
      @title = pat(:create_title, :model => "media #{@media.id}")
      flash[:success] = pat(:create_success, :model => 'Media')
      params[:save_and_continue] ? redirect(url(:medias, :index)) : redirect(url(:medias, :edit, :id => @media.id))
    else
      @title = pat(:create_title, :model => 'media')
      flash.now[:error] = pat(:create_error, :model => 'media')
      render 'medias/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "media #{params[:id]}")
    @media = Media.find(params[:id])
    if @media
      render 'medias/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'media', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "media #{params[:id]}")
    @media = Media.find(params[:id])
    if @media
      filename = Media.upload_file(params[:file])

      if filename
        @media.location = filename
      end

      if @media.update_attributes(params[:media])
        flash[:success] = pat(:update_success, :model => 'Media', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:medias, :index)) :
          redirect(url(:medias, :edit, :id => @media.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'media')
        render 'medias/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'media', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Media"
    media = Media.find(params[:id])
    if media
      if media.destroy
        flash[:success] = pat(:delete_success, :model => 'Media', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'media')
      end
      redirect url(:medias, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'media', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Media"
    unless params[:media_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'media')
      redirect(url(:medias, :index))
    end
    ids = params[:media_ids].split(',').map(&:strip).map(&:to_i)
    media = Media.find(ids)
    
    if Media.destroy media
    
      flash[:success] = pat(:destroy_many_success, :model => 'Media', :ids => "#{ids.to_sentence}")
    end
    redirect url(:medias, :index)
  end
end
