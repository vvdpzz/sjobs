class LocationsController < ApplicationController
  def new
    @location = Location.new

    respond_to do |format|
      format.html
      format.json { render :json => @location }
    end
  end

  def index
    @location = Location.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @location }
    end
  end
  
  def create
    #@location = Location.new(params[:location])
    @location = Location.create(:user_id =>current_user.id,
                                :user_name =>current_user.username,
                                :receive_time =>Time.now,
                                :lat_long => [params[:location][:longtitude].to_i,params[:location][:latitude].to_i] )    
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, :notice => 'location was successfully created.' }
        format.json { render :json => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "new" }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @location }
    end
  end

end
