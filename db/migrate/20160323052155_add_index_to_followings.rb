class AddIndexToFollowings < ActiveRecord::Migration
  def change
    add_index :followings, :follower_id
    add_index :followings, :followed_id
    add_index :followings, [:follower_id, :followed_id], unique: true
  end
end
