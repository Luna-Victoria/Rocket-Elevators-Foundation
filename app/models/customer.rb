class Customer < ApplicationRecord

  belongs_to :user
  belongs_to :address
  has_many :buildings
  has_many :intervention
  belongs_to :lead, optional: true
  after_save :verify_lead
 
  rails_admin do
    edit do
      exclude_fields :buildings
    end
  end

  def name
    "#{self.business_name}"
  end


  # After save on a customer, verify if there is a lead (for dropbox)
  def verify_lead
    puts "in verify lead"
    # verify if there is 1 lead
    if self.lead
      puts "OK____________THERE IS 1 LEAD__________________"      

        # if the lead has no attachment, print to console
        if self.lead.file_attachment == nil
          puts "__________There's no attachment in the lead_____________"
        else 
          self.lead.add_file_to_dropbox
        end        
    else
      puts "OK____________THERE IS NO LEAD__________________"
    end 

  end
end
