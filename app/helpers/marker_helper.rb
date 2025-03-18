module MarkerHelper
  def build_markers(properties)
    properties.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
        info_window_html: render_to_string(partial: "shared/info_window", locals: { property: property }),
        marker_html: render_to_string(partial: "shared/marker", locals: { property: property })
      }
    end
  end
end

