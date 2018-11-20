class GoogleController < ApplicationController

    before_action :authenticate_user!

    def google    
        
        elevators = Elevator.all
        @points_list = []

        Building.find_each do |building|

            address = building.address
            b = building.batteries.count
            b_ids = building.battery_ids
            c = Column.where(battery_id: b_ids).count
            c_ids = Column.where(battery_id: building.battery_ids).ids
            e = Elevator.where(column_id: c_ids).count

            nfloors = building.building_details.where("LOWER(information_key) like '%floor%'").first
            floors = nfloors ? nfloors.value : "Not available"

            add = " #{address.street_address}, #{address.city}, #{address.state}, #{address.zip_code}"

            @for_google = address.street_address + " " + address.city + " " + address.zip_code
            puts "for_google:#{@for_google}"
            @answer = JSON.parse(Faraday.get("https://maps.googleapis.com/maps/api/geocode/json?address=" + URI.escape(@for_google) + "&key=#{ENV["Google_API"]}").body)
            

            if @answer["status"] != "ZERO_RESULTS"
                #extract lat long
                @lat = @answer["results"][0]["geometry"]["location"]["lat"]
                @lng = @answer["results"][0]["geometry"]["location"]["lng"]

                @points_list << {name: building.building_name, 
                    lat: @lat, long: @lng, 
                    address: add, floors: floors,
                    client: building.administrator_full_name, 
                    battery: b, column: c, elevator: e,
                    technician: building.technician_full_name}
            end
        end
    end
end