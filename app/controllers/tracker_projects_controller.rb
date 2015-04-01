class TrackerProjectsController < ApplicationController

  

  def show
    if current_user.trackertoken.present?
      tracker_api = TrackerAPI.new
    @tracker_project = params[:project_name]
    @tracker_stories = tracker_api.stories(current_user.trackertoken, params[:id])
    end
  end

end
