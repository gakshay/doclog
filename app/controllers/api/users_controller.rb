class Api::UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user, :except => [:index]
  
  def index
    #@users = User.all

    respond_to do |format|
      format.html 
      format.json  { render :json => current_user }
      format.xml {render :xml => current_user}
    end
  end

  def show

    respond_to do |format|
      format.html 
      format.json  { render :json => @user , :status => :ok}
      format.xml {render :xml => @user}
    end
  end

  
  def edit
  end

  def update

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.json { head :ok }
    end
  end


  protected
  def find_user
    @user = current_user 
  end
end

