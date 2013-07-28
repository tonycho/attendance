Event::Admin.controllers :hosts do
  get :index do
    @title = "Hosts"
    @hosts = Host.all
    render 'hosts/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'host')
    @host = Host.new
    render 'hosts/new'
  end

  post :create do
    @host = Host.new(params[:host])
    if @host.save
      @title = pat(:create_title, :model => "host #{@host.id}")
      flash[:success] = pat(:create_success, :model => 'Host')
      params[:save_and_continue] ? redirect(url(:hosts, :index)) : redirect(url(:hosts, :edit, :id => @host.id))
    else
      @title = pat(:create_title, :model => 'host')
      flash.now[:error] = pat(:create_error, :model => 'host')
      render 'hosts/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "host #{params[:id]}")
    @host = Host.find(params[:id])
    if @host
      render 'hosts/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'host', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "host #{params[:id]}")
    @host = Host.find(params[:id])
    if @host
      if @host.update_attributes(params[:host])
        flash[:success] = pat(:update_success, :model => 'Host', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:hosts, :index)) :
          redirect(url(:hosts, :edit, :id => @host.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'host')
        render 'hosts/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'host', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Hosts"
    host = Host.find(params[:id])
    if host
      if host.destroy
        flash[:success] = pat(:delete_success, :model => 'Host', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'host')
      end
      redirect url(:hosts, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'host', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Hosts"
    unless params[:host_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'host')
      redirect(url(:hosts, :index))
    end
    ids = params[:host_ids].split(',').map(&:strip).map(&:to_i)
    hosts = Host.find(ids)
    
    if Host.destroy hosts
    
      flash[:success] = pat(:destroy_many_success, :model => 'Hosts', :ids => "#{ids.to_sentence}")
    end
    redirect url(:hosts, :index)
  end
end
