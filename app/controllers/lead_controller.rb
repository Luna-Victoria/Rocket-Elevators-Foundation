class LeadController < ApplicationController

  require 'sendgrid-ruby'
  include SendGrid
    
    
  def new_lead
    p = params["lead"].permit!
    puts "PARAMS = #{p}"
    file_attachment = p["file_attachment"]
    if file_attachment != nil
      p["file_attachment"] = file_attachment.read
      p["original_file_name"] = file_attachment.original_filename
    end
 
 
    lead = Lead.new(p)
    lead.valid?
    p lead.errors
    lead.save!

  comment = { :value => "The contact #{lead.full_name} from company #{lead.company_name} can be reached at email #{lead.email} and at phone number #{lead.phone}. \n \n #{lead.department} has a project name #{lead.project_name} which will require contribution from Rocket Elevators. \n \n #{lead.project_description} \n \n Attached message #{lead.message} \n \n The contact uploaded an attachment. " }


    ticket = ZendeskAPI::Ticket.new($client, :type => "question", :priority => "urgent",
        :subject => "#{lead.full_name} from #{lead.company_name}",
        :comment => comment    
    )

    ticket.save!
    
    
    # using SendGrid's Ruby Library
    # https://github.com/sendgrid/sendgrid-ruby


    data = JSON.parse("{
        \"personalizations\": [
          {
            \"to\": [
              {
                \"email\": \"#{lead.email}\"
              }
            ],
            \"dynamic_template_data\": {
                \"subject\": \"Contact Request Confirmation\",
                \"FullName\": \"#{lead.full_name}\",
                \"ProjectName\": \"#{lead.project_name}\"
            }
          }
        ],
        \"from\": {
          \"email\": \"no_reply@gmail.com\"
        },
        \"template_id\": \"d-9a08a9314948426c8ed30c49197a3f06\"
      }")
      sg = SendGrid::API.new(api_key: ENV['SendGrid_API'])
      response = sg.client.mail._("send").post(request_body: data)

  end
end