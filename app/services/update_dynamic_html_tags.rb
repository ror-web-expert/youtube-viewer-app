class UpdateDynamicHtmlTags
  def initialize(post)
    @post = post
    @job_details = @post.response_data["job_description_details"]
    @html_tags = Nokogiri::HTML(@job_details)
  end

  def formatted_job_details
    objects = []
    main_traverse(@html_tags, objects)
    @post.response_data["formatted_job_description_details"]=  objects
    @post.save
  end

  def main_traverse(node, objects)
    node.children.each do |child|
    if child.text.present?
      if child.element?
        main_traverse(child, objects)
      else
        obj = {}
        case child.parent.name
        when 'span', 'p'
          child.parent.name = 'p' # Change <span> to <p>
          obj[child.parent.name] = sub_node(child)
          objects << obj
        when 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'u'
          # binding.pry
          child.parent.name = 'h3' # Change headings and <u> tags to <h3>
          obj[child.parent.name] = sub_node(child)
          objects << obj
        end
      end
    end
    end
  end

  def sub_node(child)
    child.traverse do |next_node |
      next_node.text.strip
    end
  end

  # def traverse(node)
  #   objects = []
  #
  #   node.children.each do |child|
  #     if child.element?
  #       case child.name
  #       when 'span', 'p'
  #         child.name = 'p' # Change <span> to <p>
  #       when 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'u'
  #         child.name = 'h3' # Change headings and <u> tags to <h3>
  #       # when 'ul'
  #       #   child.name = 'li' # Change <ul> to <li>
  #       end
  #
  #       # Recursively traverse child elements and collect objects
  #       child_objects = traverse(child)
  #
  #       if child_objects.present? || child.text.strip.present?
  #         obj = {}
  #         obj[child.name] = child_objects if child_objects.present?
  #         obj[child.name] = child.text.strip if child.text.strip.present?
  #         objects << obj
  #       end
  #     end
  #   end
  #
  #   objects
  # end

end
