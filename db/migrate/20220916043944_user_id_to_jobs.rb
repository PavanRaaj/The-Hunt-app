class UserIdToJobs < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :users, null: true, foreign_key: { on_delete: :cascade, on_update: :cascade }
  end
end
