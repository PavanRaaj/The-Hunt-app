class CreateApplicantsDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :applicants_details do |t|
      t.bigint :users_id
      t.bigint :jobs_id
      t.integer :alternate_mobile_number
      t.string :address
      t.string :education

      t.timestamps
    end
  end
end
