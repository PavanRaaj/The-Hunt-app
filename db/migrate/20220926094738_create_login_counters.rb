class CreateLoginCounters < ActiveRecord::Migration[6.1]
  def change
    create_table :login_counters do |t|
      t.bigint :no_of_logins
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
