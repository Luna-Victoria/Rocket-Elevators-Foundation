class InterventionTime < ActiveRecord::Migration[5.2]
  def change
    remove_column :interventions, :starting_date
    remove_column :interventions, :ending_date
    add_column :interventions, :starting_date, :string
    add_column :interventions, :ending_date, :string
  end
end
