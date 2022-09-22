module TagsHelper
  def links_for_tags(tags)
    links =
      tags.map { |h| link_to "##{h.title}", tag_path(h) }.join(' ')

    simple_format(links, {}, wrapper_tag: :span)
  end
end
