Geocoder.configure(
  # Geocoding options
  timeout: 5,                 # geocoding service timeout (secs)
  lookup: :mapbox,         # name of geocoding service (symbol)
  api_key: ENV['MAPBOX_API_KEY=pk.eyJ1Ijoic3ByaW5nbWFudGEiLCJhIjoiY203MjB2YXV3MDR4cDJpcjB0amNyajRocCJ9.effl-zk_5oYUkE_bqJsJbA'],               # API key for geocoding service
  units: :km,                 # :km for kilometers or :mi for miles
  language: :en,              # ISO-639 language code
  # ip_lookup: :ipinfo_io,      # name of IP address geocoding service (symbol)
  # use_https: false,           # use HTTPS for lookup requests? (if supported)
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)
  # cache: nil,                 # cache object (must respond to #[], #[]=, and #del)

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [],

  # Calculation options
  # distances: :linear          # :spherical or :linear

  # Cache configuration
  # cache_options: {
  #   expiration: 2.days,
  #   prefix: 'geocoder:'
  # }
)
