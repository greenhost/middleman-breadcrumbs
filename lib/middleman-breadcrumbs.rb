require './middleman-breadcrumbs/breadcrumbs.rb'
require './middleman-breadcrumbs/version.rb'

::Middleman::Extensions.register :breadcrumbs, Breadcrumbs
