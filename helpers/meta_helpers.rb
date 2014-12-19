# inspired by middleman-bower-template
# https://github.com/headcanon/middleman-bower-template/blob/master/helpers/meta_helper.rb
# ---

module MetaHelpers

  def page_title
    title = @SITE_TITLE || ""

    if data.page.title
      title = title + " | " + data.page.title
    end

    title
  end


  def page_description
    description = @SITE_DESCRIPTION || ""

    if data.page.description
      description = data.page.description
    end

    description
  end


  def page_keywords
    keywords = if @SITE_KEYWORDS
      @SITE_KEYWORDS
    else
      []
    end

    if data.page.keywords
      keywords.concat(data.page.keywords)
    end

    keywords.uniq.join(", ")
  end

end
