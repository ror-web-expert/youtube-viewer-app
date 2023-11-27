module GeoLocationHelper

  def haversine(lat1, lon1, lat2, lon2)
    earth_radius = 3959  # Earth radius in miles

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

  def initialize_geocoder(address)
    result = Geocoder.search(address, key: Rails.application.credentials.google.geocoding_api_key, params: {countrycodes: "us"})
    result.map(&:coordinates)
  end
end
