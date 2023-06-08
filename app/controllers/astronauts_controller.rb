class AstronautsController < ApplicationController
  before_action :set_astronaut, only: %i[ show update destroy ]

  # GET /astronauts
  def index
    limit = params[:limit].to_i
    @astronauts =
      if limit.present? && limit.positive?
        Astronaut.limit(limit)
      else
        Astronaut.all
      end

    render xml: @astronauts.as_json
  end

  # GET /astronauts/1
  def show
    render xml: @astronaut.as_json
  end

  # POST /astronauts
  def create
    @astronaut = Astronaut.new(astronaut_params)

    if @astronaut.save
      render xml: @astronaut.as_json, status: :created, location: @astronaut
    else
      render xml: @astronaut.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /astronauts/1
  def update
    if @astronaut.update(astronaut_params)
      render xml: @astronaut.as_json
    else
      render xml: @astronaut.errors, status: :unprocessable_entity
    end
  end

  # DELETE /astronauts/1
  def destroy
    @astronaut.destroy
  end

  # GET /astronauts/export
  def export
    file_name = "astronauts.xml"
    xml = Astronaut.export_to_xml

    send_data xml, filename: file_name, type: 'text/xml'
  end

  # POST /astronauts/import
  def import
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_astronaut
      @astronaut = Astronaut.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def astronaut_params
      params.require(:astronaut).permit(:first_name, :last_name, :age)
    end
end
