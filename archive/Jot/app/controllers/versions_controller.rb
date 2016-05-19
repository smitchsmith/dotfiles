class VersionsController < ApplicationController

  def create
    last_version = Version.where(page_id: params[:version][:page_id]).last
    number = last_version ? last_version.number + 1 : 1
    version = Version.new(params[:version])
    version.number = number
    version.save!

    # UserMailer.page(page).deliver!
    render json: version
  end

  def update
    version = Version.find(params[:id])
    if version.update_attributes(params[:version])
      # UserMailer.page(page).deliver!
      render json: version
    else
      render json: version.errors
    end
  end

  def closest
    version = Version.where("created_at < ?", params[:version][:created_at]).last
    render json: version
  end

end
