Event::Admin.controllers :media_types do
  get :index do
    @title = "Media_types"
    @media_types = MediaType.all
    render 'media_types/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'media_type')
    @media_type = MediaType.new
    render 'media_types/new'
  end

  post :create do
    @media_type = MediaType.new(params[:media_type])
    if @media_type.save
      @title = pat(:create_title, :model => "media_type #{@media_type.id}")
      flash[:success] = pat(:create_success, :model => 'MediaType')
      params[:save_and_continue] ? redirect(url(:media_types, :index)) : redirect(url(:media_types, :edit, :id => @media_type.id))
    else
      @title = pat(:create_title, :model => 'media_type')
      flash.now[:error] = pat(:create_error, :model => 'media_type')
      render 'media_types/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "media_type #{params[:id]}")
    @media_type = MediaType.find(params[:id])
    if @media_type
      render 'media_types/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'media_type', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "media_type #{params[:id]}")
    @media_type = MediaType.find(params[:id])
    if @media_type
      if @media_type.update_attributes(params[:media_type])
        flash[:success] = pat(:update_success, :model => 'Media_type', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:media_types, :index)) :
          redirect(url(:media_types, :edit, :id => @media_type.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'media_type')
        render 'media_types/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'media_type', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Media_types"
    media_type = MediaType.find(params[:id])
    if media_type
      if media_type.destroy
        flash[:success] = pat(:delete_success, :model => 'Media_type', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'media_type')
      end
      redirect url(:media_types, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'media_type', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Media_types"
    unless params[:media_type_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'media_type')
      redirect(url(:media_types, :index))
    end
    ids = params[:media_type_ids].split(',').map(&:strip).map(&:to_i)
    media_types = MediaType.find(ids)
    
    if MediaType.destroy media_types
    
      flash[:success] = pat(:destroy_many_success, :model => 'Media_types', :ids => "#{ids.to_sentence}")
    end
    redirect url(:media_types, :index)
  end
end
