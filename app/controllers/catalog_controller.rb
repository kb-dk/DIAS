# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Blacklight::Catalog
  include Hydra::Controller::ControllerBehavior
  # These before_filters apply the hydra access controls
  #before_filter :enforce_show_permissions, :only=>:show
  # This applies appropriate access controls to all solr queries
  #CatalogController.solr_search_params_logic += [:add_access_controls_to_solr_params]
  # This filters out objects that you want to exclude from search results, like FileAssets
  # :exclude_unwanted_models << 'info:fedora/afmodel:Image'
  CatalogController.solr_search_params_logic += [:exclude_unwanted_models]
  #CatalogController.solr_search_params_logic += [:exclude_unwanted_models]
  #CatalogController.solr_search_params_logic.delete('active_fedora_model_ssi:Paper')


  configure_blacklight do |config|
    logger.info("### configure_blacklight i sproget I18n.locale=" + I18n.locale.to_s + " locale=" + :locale.to_s)
    config.default_solr_params = {
      :qf => 'title_tesim undertitel_tesim abstrakt_tesim name_namePart_tesim forfatter_tesim',
      :qt => 'search',
      :fq => 'active_fedora_model_ssi:Paper',
      #-active_fedora_model_ssi:Image
      #:search_field => 'all_fields',
      :rows => 20
    }

    # solr field configuration for search results/index views
    config.index.show_link = 'title_tesim'
    config.index.record_display_type = 'has_model'

    # solr field configuration for document/show views
    config.show.html_title = 'title_tesim'
    config.show.heading = 'title_tesim'
    config.show.display_type = 'has_model'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _tsimed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    #config.add_facet_field 'object_type_facet', :label => 'Format'
    #config.add_facet_field 'pub_date', :label => 'Publication Year'
    #config.add_facet_field 'subject_topic_facet', :label => 'Topic', :limit => 20
    #config.add_facet_field 'language_facet', :label => 'Language', :limit => true
    #config.add_facet_field 'lc_1letter_facet', :label => 'Call Number'
    #config.add_facet_field 'subject_geo_facet', :label => 'Region'
    #config.add_facet_field 'subject_era_facet', :label => 'Era'
    config.add_facet_field 'studium_tesim', :label => I18n.t('dias.views.forside.labels.studium') , :limit => 7
    config.add_facet_field 'afleveringsaar_tesim', :label => I18n.t('dias.views.forside.labels.afleveringsaar'),  :limit => 7
    config.add_facet_field 'opgavesprog_tesim', :label => I18n.t('dias.views.forside.labels.opgavesprog')#, :limit => 7
    config.add_facet_field 'opgavetype_tesim', :label => I18n.t('dias.views.forside.labels.opgavetype') #, :limit => 7

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys
    #use this instead if you don't want to query facets marked :show=>false
    #config.default_solr_params[:'facet.field'] = config.facet_fields.select{ |k, v| v[:show] != false}.keys


    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field 'title_tesim', :label => I18n.t('dias.views.forside.labels.title')
    config.add_index_field 'title_vern_display', :label => I18n.t('dias.views.forside.labels.title')

    config.add_index_field 'undertitel_tesim', :label => I18n.t('dias.views.forside.labels.undertitel')
    config.add_index_field 'undertitel_vern_tesim', :label => I18n.t('dias.views.forside.labels.undertitel')

    config.add_index_field 'forfatter_tesim', :label => I18n.t('dias.views.forside.labels.forfatter')
    config.add_index_field 'forfatter_vern_tesim', :label => I18n.t('dias.views.forside.labels.forfatter')

    config.add_index_field 'afleveringsaar_tesim', :label => I18n.t('dias.views.forside.labels.afleveringsaar')
    config.add_index_field 'afleveringsaar_vern_tesim', :label => I18n.t('dias.views.forside.labels.afleveringsaar')



    config.add_index_field 'opgavetype_tesim', :label => I18n.t('dias.views.forside.labels.opgavetype')
    config.add_index_field 'opgavetype_vern_tesim', :label => I18n.t('dias.views.forside.labels.opgavetype')


    #config.add_index_field 'author_vern_display', :label => 'Author:'
    #config.add_index_field 'format', :label => 'Format:'
    #config.add_index_field 'language_facet', :label => 'Language:'
    #config.add_index_field 'published_display', :label => 'Published:'
    #config.add_index_field 'published_vern_display', :label => 'Published:'
    #config.add_index_field 'lc_callnum_display', :label => 'Call number:'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field 'title_tesim', :label => I18n.t('dias.views.forside.labels.title')
    config.add_show_field 'undertitel_display', :label => I18n.t('dias.views.forside.labels.undertitel')

    #config.add_show_field 'title_vern_display', :label => 'Title:'
    #config.add_show_field 'subtitle_display', :label => 'Subtitle:'
    #config.add_show_field 'subtitle_vern_display', :label => 'Subtitle:'
    config.add_show_field 'forfatter_tesim', :label => I18n.t('dias.views.forside.labels.forfatter')


    config.add_show_field 'afleveringsaar_tesim', :label => I18n.t('dias.views.forside.labels.afleveringsaar')


    config.add_show_field 'studium_tesim', :label => I18n.t('dias.views.forside.labels.studium')

    config.add_show_field 'opgavesprog_tesim', :label => I18n.t('dias.views.forside.labels.opgavesprog')
    config.add_show_field 'genre_tesim', :label => I18n.t('dias.views.forside.labels.opgavetype')


    config.add_show_field 'abstrakt_tesim', :label => I18n.t('dias.views.forside.labels.abstrakt')

    #config.add_show_field 'author_vern_display', :label => 'Author:'
    #config.add_show_field 'format', :label => 'Format:'
    #config.add_show_field 'url_fulltext_display', :label => 'URL:'
    #config.add_show_field 'url_suppl_display', :label => 'More Information:'
    #config.add_show_field 'language_facet', :label => 'Language:'
    #config.add_show_field 'published_display', :label => 'Published:'
    #config.add_show_field 'published_vern_display', :label => 'Published:'
    #config.add_show_field 'lc_callnum_display', :label => 'Call number:'
    #config.add_show_field 'isbn_t', :label => 'ISBN:'


    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', :label => I18n.translate('dias.views.forside.allefelter') #'Alle Felter' #


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    config.add_search_field('Titel') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.
      field.solr_parameters = { :'spellcheck.dictionary' => 'title' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      #field.solr_local_parameters = {
      #  :qf => '$title_qf',
      #  :pf => '$title_pf'
      #}
    end

=begin
    config.add_search_field('author') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'author' }
      field.solr_local_parameters = {
        :qf => '$author_qf',
        :pf => '$author_pf'
      }
    end
=end


    config.add_search_field('Forfatter') do |field|
      #field.solr_parameters = { :'spellcheck.dictionary' => 'forfatter' }
      field.solr_local_parameters = {
          :qf => '$forfatter_qf',
          :pf => '$forfatter_pf'
      }
    end


    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
=begin
    config.add_search_field('subject') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'subject' }
      field.qt = 'search'
      field.solr_local_parameters = {
        :qf => '$subject_qf',
        :pf => '$subject_pf'
      }
    end
=end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, afleveringsaar_ssi desc, title_ssi asc', :label => 'Relevans'
    config.add_sort_field 'afleveringsaar_ssi desc, title_ssi asc', :label => 'År (nyeste først)'
    config.add_sort_field 'afleveringsaar_ssi asc, title_ssi asc', :label => 'År (ældste først)'
    config.add_sort_field 'forfatter_ssi asc, title_sort asc', :label => 'Forfatter (stigende)'
    config.add_sort_field 'forfatter_ssi desc, title_sort asc', :label => 'Forfatter (faldende)'
    config.add_sort_field 'title_ssi asc, afleveringsaar_ssi desc', :label => 'Titel'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end


  # GET /faq
  def faq
    respond_to do |format|
      format.html # faq.html.erb
    end
  end


  # GET /kontakt
  def kontakt
    respond_to do |format|
      format.html # kontakt.html.erb
    end
  end


end
