class ChangeUserModel < ActiveRecord::Migration
  def self.up
    
    drop_table :users
    create_table :users do |t|
      
           t.string :username  
           t.string :email  
           t.string :crypted_password  
           t.string :password_salt  
           t.string :persistence_token
           t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
           t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability

            # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
            t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
            t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
            t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
            t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
            t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
            t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
            t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
            
            t.integer :points, :default => 0
           
           t.timestamps  
    end
  end

  def self.down
    create_table :users, :force => true do |t|
      t.string   :name
      t.string   :hashed_password
      t.string   :salt
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :username
      t.boolean  :admin,           :default => false
      t.integer  :points,          :default => 0
      t.string   :email
    end
  end
end
