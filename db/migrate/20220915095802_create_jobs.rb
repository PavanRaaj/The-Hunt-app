class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :manager_name
      t.string :eligibility
      t.string :job_tittle
      t.text :about_job
      t.string :company_name

      t.timestamps
    end
  end
end
