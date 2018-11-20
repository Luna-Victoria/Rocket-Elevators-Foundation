class Column < ApplicationRecord
  
  def building_type_enum
    [['Residential', 0],['Commercial',1],['Corporate',2],['Hybrid',3]]
  end
   def status_enum
        [['Active', 0],['Inactive',1],['Alarm',2]]
    end
  
  
  belongs_to :battery
  has_many :elevators
  has_many :intervention
  rails_admin do
    edit do
      exclude_fields :elevator
    end
  end
end
