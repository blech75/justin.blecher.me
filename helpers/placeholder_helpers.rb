module PlaceholderHelpers

  # from middleman amicus template, tweaked to suppress width and height attrs
  # https://github.com/nathos/amicus/blob/master/config.rb#L66
  #
  # Holder.js image placeholder helper
  def img_holder(opts = {})
    return "Missing Image Dimension(s)" unless opts[:width] && opts[:height]
    return "Invalid Image Dimension(s)" unless opts[:width].to_s =~ /^\d+$/ && opts[:height].to_s =~ /^\d+$/

    img  = "<img data-src=\"holder.js/#{opts[:width]}x#{opts[:height]}/auto"
    img << "/#{opts[:bgcolor]}:#{opts[:fgcolor]}" if opts[:fgcolor] && opts[:bgcolor]
    img << "/text:#{opts[:text].gsub(/'/,"\'")}" if opts[:text]

    # suppress width and height to allow for responsive/fluid images
    # TODO: make this behavior configurable via option
    # img << "\" width=\"#{opts[:width]}\" height=\"#{opts[:height]}\">"
    # img << "\" width=\"#{opts[:width]}\""

    img << "\" />"

    img
  end

end
