class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @allUsers = User.descend_by_points()
    @users    = @allUsers.paginate :per_page => 20, :page => params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @userShows = @user.shows.find(:all, :conditions => ['date > ?', Date.current - 1.day ], :order => 'date ASC, attending DESC')
    
    if(current_user) then
      if current_user.id == @user.id then
        @currentUserViewing = true
      else
        @currentUserViewing = false
      end
    else
      @currentUserViewing = false
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
    
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid user #{params[:id]}")
      flash[:notice] = "Invalid User"
      redirect_to :action => 'index'
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      if (@user.id == current_user.id) then
        format.html
        format.xml
      else
        flash[:notice] = "Unknown Action."
        format.html { redirect_to(:controller => 'users', :action =>'index') }
      end
    end
    
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid user #{params[:id]}")
      flash[:notice] = "Invalid User"
      redirect_to :action => 'index'
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = "User #{@user.username} was successfully created."
        format.html { redirect_to(:controller => 'shows', :action =>'index') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "User #{@user.username} was successfully updated."
        format.html { redirect_to(:action =>'show', :id => @user.id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
