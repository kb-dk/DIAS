class PapersController < ApplicationController
  
  # GET /papers
  # GET /papers.json
  def index
    @papers = Paper.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @papers }
    end
  end

  # GET /papers/1
  # GET /papers/1.json
  def show
    @paper = Paper.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paper }
    end
  end

  # GET /papers/new
  # GET /papers/new.json
  def new
    @paper_languages = PaperLanguage.all
    @paper_types = PaperType.all
    @paper = Paper.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paper }
    end
  end

  # GET /papers/1/edit
  def edit
    @paper = Paper.find(params[:id])
  end

  # POST /papers
  # POST /papers.json
  def create
    @paper = Paper.new(params[:paper])
    logger.error(@paper)
    @paper.add_file(params[:content])
    respond_to do |format|
      if @paper.save
        format.html { redirect_to catalog_path(@paper), notice: t('dias.models.paper.validate.succes') }
        format.json { render json: @paper, status: :created, location: @paper }
      else
        format.html { render action: "new" }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /papers/1
  # PUT /papers/1.json
  def update
    @paper = Paper.find(params[:id])
    @paper.add_file(params[:content])
    respond_to do |format|
      if @paper.update_attributes(params[:paper])
        format.html { redirect_to @paper, notice: t('dias.models.paper.validate.succes') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papers/1
  # DELETE /papers/1.json
  def destroy
    @paper = Paper.find(params[:id])
    @paper.destroy

    respond_to do |format|
      format.html { redirect_to papers_url }
      format.json { head :no_content }
    end
  end
end
