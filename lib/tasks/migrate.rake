namespace :legacy do
  desc "Migrate legacy data"
  task :migrate => :environment do
    require File.expand_path('../../../db/legacy/migrater', __FILE__)
    migrater = Migrater.new
    migrater.go!
  end
end
