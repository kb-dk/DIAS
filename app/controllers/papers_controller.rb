class PapersController < ApplicationController
  
  #before_filter :authorize! :depositor, :all

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
    authorize! :create, @paper
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paper }
    end
  end

  # GET /papers/1/edit
  def edit
    @paper = Paper.find(params[:id])
    authorize! :edit, @paper
  end

  # POST /papers
  # POST /papers.json
  def create

    @paper = Paper.new(params[:paper])
    authorize! :create, @paper
    @paper.add_default_license
    @paper.add_user_to_rights_meta_data_stream(current_user)
    if @paper.original_filename.blank? || @paper.original_filename.nil?
      @paper.add_file(params[:content])
    else
      logger.info(" ########### opgave har allerede faaet uploadet en pdf.")
    end


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

  def reloadsolrindex
      stat_counter = 0
      @papers = Paper.all
      @papers.each do |paper|
        logger.debug("updating index for paper: " + paper.title.to_s )
        stat_counter += 1
        paper.update_index
      end
      logger.info("done reloading solr index")
      redirect_to  root_url, notice: "#{stat_counter} papers was successfully reindexed to solr."
   end


  # PUT /papers/1
  # PUT /papers/1.json
  def update
    @paper = Paper.find(params[:id])
    authorize! :update, @paper
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
    authorize! :destroy, @Paper
    @paper.destroy

    respond_to do |format|
      format.html { redirect_to papers_url }
      format.json { head :no_content }
    end
  end
end
