class CreateIntervention < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.string :author
      t.references :customer, foreign_key: true
      t.references :building, foreign_key: true
      t.references :battery, foreign_key: true
      t.references :column, foreign_key: true
      t.references :elevator, foreign_key: true
      t.references :user, foreign_key: true
      t.date :starting_date
      t.datetime :ending_date
      t.boolean :result
      t.text :report
      t.string :status
      
    end
  end
end
