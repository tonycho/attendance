Event::Admin.controllers :registrants do
  get :index do
    @title = "Registrants"
    @registrants = Registrant.all
    render 'registrants/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'registrant')
    @registrant = Registrant.new
    render 'registrants/new'
  end

  post :create do
    @registrant = Registrant.new(params[:registrant])
    if @registrant.save
      @title = pat(:create_title, :model => "registrant #{@registrant.id}")
      flash[:success] = pat(:create_success, :model => 'Registrant')
      params[:save_and_continue] ? redirect(url(:registrants, :index)) : redirect(url(:registrants, :edit, :id => @registrant.id))
    else
      @title = pat(:create_title, :model => 'registrant')
      flash.now[:error] = pat(:create_error, :model => 'registrant')
      render 'registrants/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "registrant #{params[:id]}")
    @registrant = Registrant.find(params[:id])
    if @registrant
      render 'registrants/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'registrant', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "registrant #{params[:id]}")
    @registrant = Registrant.find(params[:id])
    if @registrant
      if @registrant.update_attributes(params[:registrant])
        flash[:success] = pat(:update_success, :model => 'Registrant', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:registrants, :index)) :
          redirect(url(:registrants, :edit, :id => @registrant.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'registrant')
        render 'registrants/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'registrant', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Registrants"
    registrant = Registrant.find(params[:id])
    if registrant
      if registrant.destroy
        flash[:success] = pat(:delete_success, :model => 'Registrant', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'registrant')
      end
      redirect url(:registrants, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'registrant', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Registrants"
    unless params[:registrant_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'registrant')
      redirect(url(:registrants, :index))
    end
    ids = params[:registrant_ids].split(',').map(&:strip).map(&:to_i)
    registrants = Registrant.find(ids)
    
    if Registrant.destroy registrants
    
      flash[:success] = pat(:destroy_many_success, :model => 'Registrants', :ids => "#{ids.to_sentence}")
    end
    redirect url(:registrants, :index)
  end
end
