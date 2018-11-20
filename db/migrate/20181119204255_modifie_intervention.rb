class ModifieIntervention < ActiveRecord::Migration[5.2]
  def change
    add_column :interventions, :result, :string, :default => 'Incomplet'
    add_column :interventions, :status, :string, :default => 'Pending'
  end
end
