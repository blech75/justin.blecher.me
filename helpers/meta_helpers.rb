# inspired by middleman-bower-template
# https://github.com/headcanon/middleman-bower-template/blob/master/helpers/meta_helper.rb
# ---

module MetaHelpers

  def page_title
    title = "Justin Blecher"

    if current_resource.data.title
      title = title + " | " + current_resource.data.title
    end

    title
  end


  def page_description
    description = ""

    if current_resource.data.description
      description = current_resource.data.description
    end

    description
  end


  def page_keywords
    keywords = %w(justin blecher worksperfectly works perfectly web development)

    if current_resource.data.keywords
      keywords.concat(current_resource.data.keywords)
    end

    keywords.uniq.join(", ")
  end

end
