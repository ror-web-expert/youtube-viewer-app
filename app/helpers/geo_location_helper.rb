module GeoLocationHelper

  def haversine(lat1, lon1, lat2, lon2)
    earth_radius = 6371  # Earth radius in kilometers

    dlat = radians(lat2 - lat1)
    dlon = radians(lon2 - lon1)

    a = Math.sin(dlat / 2) ** 2 + Math.cos(radians(lat1)) * Math.cos(radians(lat2)) * Math.sin(dlon / 2) ** 2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    distance = earth_radius * c
    return distance
  end

  private

  def radians(degrees)
    degrees * Math::PI / 180
  end

  def initialize_opencage_geocoder
    result = OpenCage::Geocoder.new(api_key: 'fa93e7ffcb0249ffb0c49d1d387c1d89').geocode(request.ip)
    result.first.coordinates
  end
end
