$:.push File.expand_path("../lib", __FILE__)
require "middleman-breadcrumbs/version"

Gem::Specification.new do |s|
  s.name        = "middleman-breadcrumbs"
  s.version     = BreadcrumbsVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Chris Snijder"]
  s.email       = ["info@greenhost.nl"]
  s.homepage    = "http://github.com/greenhost/middleman-breadcrumbs"
  s.summary     = %q{Breadcrumbs helper for Middleman}
  s.description = %q{Breadcrumbs helper with images for Middleman, based on marnen/middleman-breadcrumbs}
  s.license = 'MIT'

  s.required_ruby_version = '>= 2.4.2'

  s.add_runtime_dependency "middleman", '>= 4.0.0'
  s.files         = `git ls-files`.split("\n") - %w(.gitignore .ruby-version)
  s.executables   = []
  s.require_paths = ["lib"]
end
