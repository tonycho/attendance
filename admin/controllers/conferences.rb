Event::Admin.controllers :conferences do
  get :index do
    @title = "Conferences"
    @conferences = Conference.all
    render 'conferences/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'conference')
    @conference = Conference.new
    @category = Category.new(params[:category])

    @conference_options = []

    Conference.all.each do |c|
      @conference_options << [ c.name, c.id ]
    end

    render 'conferences/new'
  end

  post :create do
    @conference = Conference.new(params[:id])
    @category = Category.new(params[:category])
    if @conference.save
      @title = pat(:create_title, :model => "conference #{@conference.id}")
      flash[:success] = pat(:create_success, :model => 'Conference')
      params[:save_and_continue] ? redirect(url(:conferences, :index)) : redirect(url(:conferences, :edit, :id => @conference.id))
    else
      @title = pat(:create_title, :model => 'conference')
      flash.now[:error] = pat(:create_error, :model => 'conference')
      render 'conferences/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "conference #{params[:id]}")
    @conference = Conference.find(params[:id])
    @category = Category.new(params[:category])

    @conference_options = []

    Conference.where("id <> ? AND (parent_conference_id IS NULL OR parent_conference_id <> ?)", @conference.id, @conference.id).each do |c|
      @conference_options << [ c.name, c.id ]
    end


    if @conference
      render 'conferences/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'conference', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "conference #{params[:id]}")
    @conference = Conference.find(params[:id])
    if @conference
      if @conference.update_attributes(params[:conference])
        flash[:success] = pat(:update_success, :model => 'Conference', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:conferences, :index)) :
          redirect(url(:conferences, :edit, :id => @conference.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'conference')
        render 'conferences/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'conference', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Conferences"
    conference = Conference.find(params[:id])
    if conference
      if conference.destroy
        flash[:success] = pat(:delete_success, :model => 'Conference', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'conference')
      end
      redirect url(:conferences, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'conference', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Conferences"
    unless params[:conference_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'conference')
      redirect(url(:conferences, :index))
    end
    ids = params[:conference_ids].split(',').map(&:strip).map(&:to_i)
    conferences = Conference.find(ids)
    
    if Conference.destroy conferences
    
      flash[:success] = pat(:destroy_many_success, :model => 'Conferences', :ids => "#{ids.to_sentence}")
    end
    redirect url(:conferences, :index)
  end
end
