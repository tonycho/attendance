Attendance::Admin.controllers :members do
  get :index do
    @title = "Members"
    @members = Member.all
    render 'members/index'
  end

  get "/select" do
   content_type :json
   Member.selectautocomplete(params[:term]).to_json
  end

  get :new do
    @title = pat(:new_title, :model => 'member')
    @member = Member.new
    render 'members/new'
  end

  post :create do
    @member = Member.new(params[:member])
    if @member.save
      @title = pat(:create_title, :model => "member #{@member.id}")
      flash[:success] = pat(:create_success, :model => 'Member')
      params[:save_and_continue] ? redirect(url(:members, :index)) : redirect(url(:members, :edit, :id => @member.id))
    else
      @title = pat(:create_title, :model => 'member')
      flash.now[:error] = pat(:create_error, :model => 'member')
      render 'members/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "member #{params[:id]}")
    @member = Member.find(params[:id])
    if @member
      render 'members/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'member', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "member #{params[:id]}")
    @member = Member.find(params[:id])
    if @member
      if @member.update_attributes(params[:member])
        flash[:success] = pat(:update_success, :model => 'Member', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:members, :index)) :
          redirect(url(:members, :edit, :id => @member.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'member')
        render 'members/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'member', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Members"
    member = Member.find(params[:id])
    if member
      if member.destroy
        flash[:success] = pat(:delete_success, :model => 'Member', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'member')
      end
      redirect url(:members, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'member', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Members"
    unless params[:member_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'member')
      redirect(url(:members, :index))
    end
    ids = params[:member_ids].split(',').map(&:strip).map(&:to_i)
    members = Member.find(ids)
    
    if Member.destroy members
    
      flash[:success] = pat(:destroy_many_success, :model => 'Members', :ids => "#{ids.to_sentence}")
    end
    redirect url(:members, :index)
  end
end
