class CommuterRailService

  require 'csv'
  require 'open-uri'
  require 'date'


  BASE_URL = "http://developer.mbta.com/lib/gtrtfs/Departures.csv"

  # Get a hash object that the front-end can use to display the big board
  def hash
    north_station = []
    south_station = []

    CSV.new(open(BASE_URL), :headers => :first_row).each do |line|
      #Pull out the important info
      new_hash = {
        train: line[2],
        destination: line[3],
        scheduled: seconds_to_time(line[4]),
        estimated: seconds_to_time(line[4].to_i + line[5].to_i),
        track: line[6],
        status: line[7]
      }

      #Check to see if this is a North Station or a South Station Train
      if line[1] == "North Station"
        north_station << new_hash
      elsif line[1] == "South Station"
        south_station << new_hash
      end

    end

    return {north_station: north_station, south_station: south_station}

  end

  #Convert Epoch to Human Readable Time
  def seconds_to_time int_time
    #Convert Epoch Time to Ruby Time Object
    time = DateTime.strptime(int_time.to_s,'%s').in_time_zone('Eastern Time (US & Canada)')

    #Convert Ruby time Object to Human Readabale String
    return time.strftime("%l:%M %p")
  end

end