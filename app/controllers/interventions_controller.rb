class InterventionsController < ApplicationController
  before_action :set_intervention, only: [:show, :edit, :update, :delete]

  # GET /interventions
  # GET /interventions.json
  def index
    @interventions = Intervention.all
  end

  def filter_elevators_by_column
    @filtered_elevators = Elevator.where(column_id: params[:selected_column])
  end

  def filter_columns_by_battery
    @filtered_columns = Column.where(battery_id: params[:selected_battery])
  end

  def filter_batteries_by_building
    @filtered_batteries = Battery.where(building_id: params[:selected_building])
  end

  def filter_buildings_by_customer
    @filtered_buildings = Building.where(customer_id: params[:selected_customer])
  end

  # GET /interventions/1
  # GET /interventions/1.json
  def show
  end

  # GET /interventions/new
  def new
    @intervention = Intervention.new
  end

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions
  # POST /interventions.json
  def create
    @intervention = Intervention.new(intervention_params)
    puts @intervention
    
    respond_to do |format|
      if @intervention.save
        format.html { redirect_to @intervention, notice: 'Intervention was successfully created.' }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
    

    comment = { :value => "The contact # #{@intervention.author}
    from company # #{@intervention.customer.business_name} 
    has create a intervention for the elevator # #{@intervention.elevator_id} 
    from the column # #{@intervention.column_id}, 
    in the battery # #{@intervention.battery_id},
    in the building # #{@intervention.building_id} (#{@intervention.building.building_name})."}

    ticket = ZendeskAPI::Ticket.new($client, :type => "Support", :priority => "urgent",
      :subject => "#{@intervention.author} from #{@intervention.customer.business_name}",
      :comment => comment)

    ticket.save!

  end

  # PATCH/PUT /interventions/1
  # PATCH/PUT /interventions/1.json
  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to @intervention, notice: 'Intervention was successfully updated.' }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interventions/1
  # DELETE /interventions/1.json
  def delete
    @intervention.delete
    respond_to do |format|
      format.html { redirect_to interventions_url, notice: 'Intervention was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def intervention_params
      params.require(:intervention).permit(:author, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :starting_date, :ending_date, :employee_id, :report, :status)
    end
end
