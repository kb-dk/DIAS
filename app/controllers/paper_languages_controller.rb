class PaperLanguagesController < ApplicationController
  # GET /paper_languages
  # GET /paper_languages.json
  def index
    @paper_languages = PaperLanguage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paper_languages }
    end
  end

  # GET /paper_languages/1
  # GET /paper_languages/1.json
  def show
    @paper_language = PaperLanguage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @paper_language }
    end
  end

  # GET /paper_languages/new
  # GET /paper_languages/new.json
  def new
    @paper_language = PaperLanguage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @paper_language }
    end
  end

  # GET /paper_languages/1/edit
  def edit
    @paper_language = PaperLanguage.find(params[:id])
  end

  # POST /paper_languages
  # POST /paper_languages.json
  def create
    @paper_language = PaperLanguage.new(params[:paper_language])

    respond_to do |format|
      if @paper_language.save
        format.html { redirect_to @paper_language, notice: 'Paper language was successfully created.' }
        format.json { render json: @paper_language, status: :created, location: @paper_language }
      else
        format.html { render action: "new" }
        format.json { render json: @paper_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paper_languages/1
  # PUT /paper_languages/1.json
  def update
    @paper_language = PaperLanguage.find(params[:id])

    respond_to do |format|
      if @paper_language.update_attributes(params[:paper_language])
        format.html { redirect_to @paper_language, notice: 'Paper language was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @paper_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paper_languages/1
  # DELETE /paper_languages/1.json
  def destroy
    @paper_language = PaperLanguage.find(params[:id])
    @paper_language.destroy

    respond_to do |format|
      format.html { redirect_to paper_languages_url }
      format.json { head :no_content }
    end
  end
end
