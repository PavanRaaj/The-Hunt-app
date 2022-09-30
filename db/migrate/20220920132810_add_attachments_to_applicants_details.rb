class AddAttachmentsToApplicantsDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :applicants_details, :attachment, :string
  end
end
