class BinariesController < ApplicationController

  def create
    file, title, page_id = params[:file], params[:title], params[:page_id]
    @binary = Binary.new(file: file, title: title, page_id: page_id)
    @binary.save!
    render json: build_json
  end

  def destroy
    @binary = Binary.find(params[:id])
    @binary.destroy
    render json: build_json
  end

  # private
  def build_json
    Jbuilder.encode do |json|
      json.(@binary, :page_id, :title, :created_at, :updated_at, :id)
      json.url @binary.file.url
    end
  end

end
