class InterventionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]
  
  # GET /interventions
  # GET /interventions.json
  def index
    @interventions = Intervention.all
  end

  
  # Dynamic select menu
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
    @intervention.author = current_user.employee.id
     

    respond_to do |format|
      if @intervention.save
        format.html { redirect_to @intervention, notice: 'Intervention was successfully created.' }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end


    # Zendesk controller
    comment = { :value => 
    "Welcome. 
    
    The employee #{current_user.employee.first_name} #{current_user.employee.last_name} has create a intervention for the 
    company #{@intervention.customer.business_name} building # #{@intervention.building_id} (#{@intervention.building.building_name}), 
    in the battery # #{@intervention.battery_id}, from the column # #{@intervention.column_id}, for the elevator # #{@intervention.elevator_id}. 
    The employee #{@intervention.employee.first_name} #{@intervention.employee.last_name} has been selected for the work.
    Please read the following report: #{@intervention.report} 

    Thank you!"}

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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

  # DELETE /interventions/1
  # DELETE /interventions/1.json
  def destroy
    @intervention.destroy
    respond_to do |format|
      format.html { redirect_to interventions_url, notice: 'Intervention was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def intervention_params
      params.require(:intervention).permit(:author, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :starting_date, :ending_date, :employee_id, :report, :status)
    end
end
