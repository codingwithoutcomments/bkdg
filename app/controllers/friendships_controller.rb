class FriendshipsController < ApplicationController

  # POST /friendships
  # POST /friendships.xml
  def create
    @user = User.find(params[:friend_id])
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    @friendship.save
   
    respond_to do |format|
        format.js
     end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.xml
  def destroy
    @user = User.find(params[:user])
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
  
    respond_to do |format|
      format.js
    end
  end

end
