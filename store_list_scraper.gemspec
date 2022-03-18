# frozen_string_literal: true

require_relative "lib/storeListScraper/version"

Gem::Specification.new do |spec|
  spec.name = "store_list_scraper"
  spec.version = ListScraper::VERSION
  spec.authors = ["itsmattpaw"]
  spec.email = ["itsmattpaw@gmail.com"]

  spec.summary = "Scrape Store Address lists from StoreFound.org."
  spec.description = "Scrape Store Address lists from StoreFound.org and export into a CSV file for distribution or use withe other softwares such as ESRI ARC GIS."
  spec.homepage = "https://github.com/itsmattpaw/store_list_scraper"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  #spec.metadata["allowed_push_host"] = "https://example.com"

  #spec.metadata["homepage_uri"] = spec.homepage
  #spec.metadata["source_code_uri"] = "http://www.bob.com"
  #spec.metadata["changelog_uri"] = "http://www.bob.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "pry"
  spec.add_dependency 'nokogiri', '~> 1.13'
  spec.add_dependency "open-uri"
  spec.add_dependency "csv"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
