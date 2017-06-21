class VersionController < ApplicationController
  before_action :set_version, only: [:index]

  def index
    render json: @version
  end

  private

  def set_version
    @version ||= VERSION_INFO
  end

end
