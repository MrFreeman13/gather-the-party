class DistanceToPoint
  POINT_LATITUDE = 53.339428
  POINT_LONGITUDE = -6.257664
  EARTH_RADIUS = 6372.795

  def initialize(point_latitude = POINT_LATITUDE, point_longitute = POINT_LONGITUDE)
    @from_latitude_radians = convert_to_radians(point_latitude)
    @from_longitude_radians = convert_to_radians(point_longitute)
    @from_latitude_cos = Math.cos(@from_latitude_radians)
    @from_latitude_sin = Math.sin(@from_latitude_radians)
  end

  def calculate(latitude, longitude)
    to_latitude_radians = convert_to_radians(latitude)
    to_longitude_radians = convert_to_radians(longitude)

    to_latitude_cos = Math.cos(to_latitude_radians)
    to_latitude_sin = Math.sin(to_latitude_radians)

    delta = to_longitude_radians - @from_longitude_radians

    cos_delta = Math.cos(delta)
    sin_delta = Math.sin(delta)

    y = Math.sqrt((to_latitude_cos*sin_delta)**2 + (@from_latitude_cos*to_latitude_sin - @from_latitude_sin*to_latitude_cos*cos_delta)**2)
    x = @from_latitude_sin*to_latitude_sin + @from_latitude_cos*to_latitude_cos*cos_delta

    dist = (Math.atan2(y, x)*EARTH_RADIUS).round
  end

  private

  def convert_to_radians(coordinate)
    if coordinate.is_a?(Float)
      return coordinate*Math::PI/180
    else
      raise ArgumentError.new("Coordinate `#{coordinate}` must be a float value")
    end
  end
end
