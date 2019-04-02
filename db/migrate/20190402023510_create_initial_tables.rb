class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :users, {:id => false} do |t|
      t.integer :user_id
      t.integer :obf_user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username
      t.string :password
      t.boolean :is_admin
    end

    create_table :projects, {:id => false} do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :project_name
    end

    create_table :participants, {:id => false} do |t|
      t.string :participant_email
      t.integer :project_id
    end

    create_table :project_times, {:id => false} do |t|
      t.integer :project_time_id
      t.integer :project_id
      t.timestamp :start_time
      t.timestamp :end_time
      t.date :date
    end

    create_table :participant_ranked_times, {:id => false} do |t|
      t.string :participant_email
      t.float :ranking
      t.integer :project_time_id
    end
  end
end

