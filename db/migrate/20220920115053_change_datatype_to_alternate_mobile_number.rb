class ChangeDatatypeToAlternateMobileNumber < ActiveRecord::Migration[6.1]
  def change
    change_column(:applicants_details, :alternate_mobile_number, :bigint)
  end
end
