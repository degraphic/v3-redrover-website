class CalendarController < ApplicationController
  def index
    calendar_information = params[:content]
    respond_to do |format|
     format.ics { send_data(calendar_information, :filename=>"event.ics", :disposition=>"inline; filename=mycal.ics", :type=>"text/calendar")}
    end
  end
end
