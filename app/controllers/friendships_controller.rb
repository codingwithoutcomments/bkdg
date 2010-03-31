class FriendshipsController < ApplicationController

  # POST /friendships
  # POST /friendships.xml
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])

      if @friendship.save
        flash[:notice] = 'Added Friend'
        redirect_to root_url
      else
        flash[:notice] = 'Unable To Add Friend'
        redirect_to root_url
      end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.xml
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed Friendship."
    redirect_to current_user

  end
end
