class PaperTypesController < ApplicationController
  # GET /paper_types
  # GET /paper_types.json
  def index
    @paper_types = PaperType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paper_types }
    end
  end

  # GET /paper_types/1
  # GET /paper_types/1.json
  def show
    @paper_type = PaperType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paper_type }
    end
  end

  # GET /paper_types/new
  # GET /paper_types/new.json
  def new
    @paper_type = PaperType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paper_type }
    end
  end

  # GET /paper_types/1/edit
  def edit
    @paper_type = PaperType.find(params[:id])
  end

  # POST /paper_types
  # POST /paper_types.json
  def create
    @paper_type = PaperType.new(params[:paper_type])

    respond_to do |format|
      if @paper_type.save
        format.html { redirect_to @paper_type, notice: 'Paper type was successfully created.' }
        format.json { render json: @paper_type, status: :created, location: @paper_type }
      else
        format.html { render action: "new" }
        format.json { render json: @paper_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paper_types/1
  # PUT /paper_types/1.json
  def update
    @paper_type = PaperType.find(params[:id])

    respond_to do |format|
      if @paper_type.update_attributes(params[:paper_type])
        format.html { redirect_to @paper_type, notice: 'Paper type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paper_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paper_types/1
  # DELETE /paper_types/1.json
  def destroy
    @paper_type = PaperType.find(params[:id])
    @paper_type.destroy

    respond_to do |format|
      format.html { redirect_to paper_types_url }
      format.json { head :no_content }
    end
  end
end
