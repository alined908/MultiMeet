class CreateInitialTables < ActiveRecord::Migration
  def change
    # USERS
    create_table :users do |t|
      # default: t.primary_key :id => integer
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :password_confirmation
      t.string :password_digest
      t.timestamps
    end


    # PROJECTS
    # primary key: integer id
    # foreign key: username => users.username
    # duration: integer of number of minutes per project meeting
    create_table :projects do |t|
      # default: t.primary_key :id => integer
      t.string :project_name, null: false
      t.integer :user_id, null: false
      t.integer :duration
    end

    # user_id => users.id
    add_foreign_key :projects, :users,
                    column: :username, primary_key: :username


    # PARTICIPANTS
    create_table :participants do |t|
      # default: t.primary_key :id => integer
      t.integer :project_id, null: false # :projects.id
      t.string :email, null: false
    end

    # for (project_id, email) as PKEY
    add_index :participants, [:project_id, :email], unique: true


    # PROJECT_TIMES
    # primary key: integer id
    # foreign key: project_id => projects.id
    # is_date: true if date_time stores date,
    #         false if date_time stores start time
    create_table :project_times do |t|
      # default: t.primary_key :id => integer
      t.integer :project_id, null: false
      t.timestamp :date_time, null: false
      t.boolean :is_date, null: false, default: false
    end

    # project_date_id => project_dates.id
    add_foreign_key :project_times, :project_dates,
                    column: :project_date_id, primary_key: :id


    # PARTICIPANT_RANKED_TIMES
    # primary key: integer id
    # foreign key: participants.id
    #              project_times.id
    create_table :rankings do |t|
      t.integer :ranking
      t.integer :participant_id, null: false
      t.integer :project_time_id, null: false
    end

    # for (participants.id, project_times.id) unique
    add_index :rankings, [:participant_id, :project_time_id], unique: true

    # participant_id => participants.id
    add_foreign_key :rankings, :participants
    # project_time_id => project_times.id
    add_foreign_key :rankings, :project_times
  end
end

