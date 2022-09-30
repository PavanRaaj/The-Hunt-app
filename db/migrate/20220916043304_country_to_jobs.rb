class CountryToJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :jobs, :country, :string
  end
end
