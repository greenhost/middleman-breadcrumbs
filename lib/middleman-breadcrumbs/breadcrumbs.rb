require 'middleman'
require File.join(File.dirname(__FILE__), 'version')
require 'rack/utils'
require 'padrino-helpers'

class Breadcrumbs < Middleman::Extension
  include BreadcrumbsVersion
  include Padrino::Helpers

  option :separator, ' > ', 'Default separator between breadcrumb levels'
  option :wrapper, nil, 'Name of tag (as symbol) in which to wrap each breadcrumb level, or nil for no wrapping'
  option :img_attr, nil, 'Attributes for breadcrumb images.'

  expose_to_template :breadcrumbs

  def initialize(app, options_hash = {}, &block)
    super
    @separator = options.separator
    @wrapper = options.wrapper
    @img_attr = options.img_attr
  end

  def breadcrumbs(current_page, separator: @separator, wrapper: @wrapper, img_att: @img_attr)
    hierarchy = [current_page]
    hierarchy.unshift hierarchy.first.parent while hierarchy.first.parent
    hierarchy.map { |page|
      title = page.data.breadcrumb.title rescue page.data.title
      img =  page.data.breadcrumb.img rescue ""
      if img
        img = tag(:img, :src => img, **img_attr)
      end
      title = "#{img}#{title}" % {
        :img => img,
        :title => title
      }
      wrap link_to(title, page.url), wrapper: wrapper
    }.join(h separator)
  end

  private

  def wrap(content, wrapper: nil)
    wrapper ? content_tag(wrapper) { content } : content
  end
end
