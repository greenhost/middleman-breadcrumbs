require 'middleman'
require File.join(File.dirname(__FILE__), 'version')
require 'rack/utils'
require 'padrino-helpers'

class Breadcrumbs < Middleman::Extension
  include BreadcrumbsVersion
  include Padrino::Helpers

  option :separator, ' > ', 'Default separator between breadcrumb levels'
  option :wrapper, nil, 'Name of tag (as symbol) in which to wrap each breadcrumb level, or nil for no wrapping'
  option :img_attrs, {}, 'Attributes for breadcrumb images.'

  expose_to_template :breadcrumbs

  def initialize(app, options_hash = {}, &block)
    super
    @separator = options.separator
    @wrapper = options.wrapper
    @img_attrs = options.img_attrs
  end

  def breadcrumbs(current_page, separator: @separator, wrapper: @wrapper, img_attrs: @img_attrs)
    hierarchy = [current_page]
    hierarchy.unshift hierarchy.first.parent while hierarchy.first.parent
    hierarchy.map { |page|
      # Get title from the breadcrumb section in frontmatter or from the page
      title = page.data.breadcrumb.title rescue page.data.title
      # If title if false set it to an empty string
      title = title || ""
      # Get an image from the breadcrumb section in frontmatter if set
      img = page.data.breadcrumb.img rescue nil
      if img
        img = tag(:img, :src => img, **img_attrs)
      end
      link = "#{img}#{title}"
      wrap link_to(page.url) { mark_safe(link) }, wrapper: wrapper
    }.join(h separator)
  end

  private

  def wrap(content, wrapper: nil)
    wrapper ? content_tag(wrapper) { content } : content
  end
end
