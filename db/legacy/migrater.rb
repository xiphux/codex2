class LegacyGenre < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "genres"
  attr_accessible :name

  def migrate!
    genre = Genre.new :name => self.name
    genre.id = self.id
    genre.save
    puts "Migrated genre #{genre.id}: #{genre.name}"
  end
end

class LegacySeries < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "series"
  attr_accessible :title

  def migrate!
    series = Series.new :title => self.title
    series.id = self.id
    series.save
    puts "Migrated series #{series.id}: #{series.title}"
  end
end

class LegacyCharacterSeries < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "characters_series"
  attr_accessible :character_id, :series_id
end

class LegacyCharacter < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "characters"
  attr_accessible :name

  def migrate!
    char = Character.new :name => self.name
    char.id = self.id

    char_series = LegacyCharacterSeries.find(:first, :conditions => [ "character_id = ?", self.id ])
    if (char_series != nil) && (char_series.series_id != nil) then
      char.series = Series.find(char_series.series_id)
    end

    char.save

    puts "Migrated character #{char.id}: #{char.name} (#{char.series.title})"
  end
end

class LegacyMatchup < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "matchups"
  attr_accessible :character1, :character2

  def migrate!
    match = Matchup.new
    match.id = self.id

    if self.character1 != nil then
      char1 = Character.find(self.character1)
      if char1 != nil then
        match.characters << char1
      end
    end

    if self.character2 != nil then
      char2 = Character.find(self.character2)
      if char2 != nil then
        match.characters << char2
      end
    end

    match.save

    puts "Migrated matchup #{match.id}: " + match.characters.map { |c| c.name + " (" + c.series.title + ")" }.join(" + ")
  end
end

class LegacyAuthor < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "authors"
  attr_accessible :name, :email, :website

  def migrate!
    author = Author.new :name => self.name, :email => self.email, :website => self.website
    author.id = self.id
    author.save

    puts "Migrated author #{author.id}: " + (author.name != nil ? author.name : "Unknown") + (author.email != nil ? " <" + author.email + ">" : "") + (author.website != nil ? " [" + author.website + "]" : "")
  end
end

class LegacyFicAuthor < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "fic_author"
  attr_accessible :fic_id, :author_id
end

class LegacyFicGenre < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "fic_genre"
  attr_accessible :fic_id, :genre_id
end

class LegacyFicSeries < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "fic_series"
  attr_accessible :fic_id, :series_id
end

class LegacyFicMatchup < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "fic_matchup"
  attr_accessible :fic_id, :matchup_id
end

class LegacyFic < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "fics"
  attr_accessible :title, :sequel_to, :sidestory_to

  def migrate!
    fic = Fic.new :title => self.title
    fic.id = self.id

    if self.sequel_to != nil then
      fic.prequel = Fic.find(self.sequel_to)
    end

    if self.sidestory_to != nil then
      main = Fic.find(self.sidestory_to)
      if main != nil then
        fic.main_story = main
      end
    end

    fic_authors = LegacyFicAuthor.where("fic_id = ?", self.id)
    fic_authors.each do |fa|
      if fa.author_id != nil then
        author = Author.find(fa.author_id)
	if author != nil then
	  fic.authors << author
	end
      end
    end

    fic_genres = LegacyFicGenre.where("fic_id = ?", self.id)
    fic_genres.each do |fg|
      if fg.genre_id != nil then
        genre = Genre.find(fg.genre_id)
	if genre != nil then
	  fic.genres << genre
	end
      end
    end

    fic_series = LegacyFicSeries.where("fic_id = ?", self.id)
    fic_series.each do |fs|
      if fs.series_id != nil then
        series = Series.find(fs.series_id)
	if series != nil then
	  fic.series << series
	end
      end
    end

    fic_matchups = LegacyFicMatchup.where("fic_id = ?", self.id)
    fic_matchups.each do |fm|
      if fm.matchup_id != nil then
        matchup = Matchup.find(fm.matchup_id)
	if matchup != nil then
	  fic.matchups << matchup
	end
      end
    end

    fic.save

    puts "Migrated fic #{fic.id}: #{fic.title}"
    puts "  Authors: " + fic.authors.map { |a| a.name }.join(", ")
    puts "  Genres: " + fic.genres.map { |g| g.name }.join(", ")
    puts "  Series: " + fic.series.map { |s| s.title }.join(", ")
    puts "  Matchups: " + fic.matchups.map { |m| m.characters.map { |c| c.name }.join(" + ") }.join(", ")
    if fic.prequel != nil then
      puts "  Sequel to: " + fic.prequel.title
    end
    if fic.main_story != nil then
      puts "  Sidestory to: " + fic.main_story.title
    end

  end
end

class LegacyChapter < ActiveRecord::Base
  establish_connection :legacy
  set_table_name "chapters"
  attr_accessible :fic, :num, :title, :file, :data, :wrapped, :padlines, :views

  def migrate!
    chapter = Chapter.new :number => self.num, :title => self.title, :file => self.file, :data => self.data, :wrapped => self.wrapped, :no_paragraph_spacing => self.padlines, :views => self.views
    chapter.id = self.id
    chapter.word_count = chapter.calculate_word_count

    if self.fic != nil
      chapter.fic = Fic.find(self.fic)
    end

    chapter.save

    puts "Migrated chapter #{chapter.id}: #{chapter.fic.title} chapter #{chapter.number}" + (chapter.title != nil ? ": " + chapter.title : "")
  end
end

class Migrater
  def go!
    # truncate tables
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE authors")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE authors_fics")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE chapters")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE characters")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE characters_matchups")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE fics")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE fics_genres")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE fics_matchups")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE fics_series")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE genres")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE matchups")
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE series")

    # migrate series
    series = LegacySeries.all
    series.each do |s|
      s.migrate!
    end
    new_increment_value = LegacySeries.find(:first, :order => 'id DESC').id + 1
    ActiveRecord::Base.connection.execute("ALTER TABLE series AUTO_INCREMENT = #{new_increment_value}")

    # migrate genres
    genres = LegacyGenre.all
    genres.each do |g|
      g.migrate!
    end
    new_increment_value = LegacyGenre.find(:first, :order => 'id DESC').id + 1
    ActiveRecord::Base.connection.execute("ALTER TABLE genres AUTO_INCREMENT = #{new_increment_value}")

    # migrate characters
    chars = LegacyCharacter.all
    chars.each do |c|
      c.migrate!
    end
    new_increment_value = LegacyCharacter.find(:first, :order => 'id DESC').id + 1
    ActiveRecord::Base.connection.execute("ALTER TABLE characters AUTO_INCREMENT = #{new_increment_value}")

    # migrate matchups
    matchups = LegacyMatchup.all
    matchups.each do |m|
      m.migrate!
    end
    new_increment_value = LegacyMatchup.find(:first, :order => 'id DESC').id + 1
    ActiveRecord::Base.connection.execute("ALTER TABLE matchups AUTO_INCREMENT = #{new_increment_value}")

    # migrate authors
    authors = LegacyAuthor.all
    authors.each do |a|
      a.migrate!
    end
    new_increment_value = LegacyAuthor.find(:first, :order => 'id DESC').id + 1
    ActiveRecord::Base.connection.execute("ALTER TABLE authors AUTO_INCREMENT = #{new_increment_value}")

    # migrate standalone fics first
    fics = LegacyFic.where('sequel_to IS NULL AND sidestory_to IS NULL')
    fics.each do |f|
      f.migrate!
    end
    # then migrate fics linked to others
    fics = LegacyFic.where('sequel_to IS NOT NULL OR sidestory_to IS NOT NULL')
    fics.each do |f|
      f.migrate!
    end
    new_increment_value = LegacyFic.find(:first, :order => 'id DESC').id + 1
    ActiveRecord::Base.connection.execute("ALTER TABLE fics AUTO_INCREMENT = #{new_increment_value}")

    # migrate chapters
    chaps = LegacyChapter.all
    chaps.each do |c|
      c.migrate!
    end
    new_increment_value = LegacyChapter.find(:first, :order => 'id DESC').id + 1
    ActiveRecord::Base.connection.execute("ALTER TABLE chapters AUTO_INCREMENT = #{new_increment_value}")

  end
end
