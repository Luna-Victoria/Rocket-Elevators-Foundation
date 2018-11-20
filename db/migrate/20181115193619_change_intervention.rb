class ChangeIntervention < ActiveRecord::Migration[5.2]
  def change
    remove_column :interventions, :user_id
    add_reference :interventions, :employee, foreign_key: true
  end
end
