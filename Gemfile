source "https://rubygems.org"

branch = ENV.fetch("SOLIDUS_BRANCH", "master")
if branch == "master" || branch >= "v2.0"
  gem "rails-controller-testing", group: :test
end

group :development, :test do
  gem "solidus", github: 'solidusio/solidus', branch: branch
  gem "solidus_auth_devise"


  gem "pg"
  gem "mysql2"
  gem "sqlite3"
end

group :test do
  gem "database_cleaner"
  gem "factory_girl"
  gem "timecop"
  gem "vcr"
  gem "webmock"
  gem "selenium-webdriver"
end

gemspec
