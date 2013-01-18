class DownloadsController < ApplicationController


  def show
    asset = ActiveFedora::Base.find(params[:id])
    raise ActionController::RoutingError.new('Not Found') if asset.nil?
    send_content (asset)
  end


  def send_content (asset)
    opts = {}
    ds = asset.datastreams["content"];
    raise ActionController::RoutingError.new('Not Found') if ds.nil?
    opts[:filename] = ds.label
    opts[:disposition] = "inline"
    opts[:type] = ds.mimeType
    send_data ds.content, opts
    return
  end

end
