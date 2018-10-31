require './lib/photograph'
require './lib/artist'
require './lib/file_io'

class Curator
  attr_reader :photographs, :artists, :file_io
  def initialize
    @photographs = []
    @artists = []
  end

  def add_artist(attributes)
    @artists << Artist.new(attributes)
  end

  def add_photograph(attributes)
    @photographs << Photograph.new(attributes)
  end

  def find_artist_by_id(id)
    artists.find {|artist| artist.id == id}
  end

  def find_photograph_by_id(id)
    photographs.find {|photo| photo.id == id}
  end

  def find_photographs_by_artist(artist)
    photographs.find_all {|photo| photo.artist_id == artist.id}
  end

  def artists_with_multiple_photographs
    artists.find_all {|artist| find_photographs_by_artist(artist).count > 1}
  end

  def photographs_taken_by_artists_from(country)
    photographs.find_all do |photo|
      find_artist_by_id(photo.artist_id).country == country
    end
  end

  def load_photographs(file)
    photos = FileIO.load_photographs(file)
    photos.each {|photo_hash| add_photograph(photo_hash)}
  end

  def load_artists(file)
    artists = FileIO.load_artists(file)
    artists.each {|artist_hash| add_artist(artist_hash)}
  end

  def photographs_taken_between(date_range)
    photographs.find_all do |photo|
      photo.year > date_range.first.to_s &&
      photo.year < date_range.last.to_s
    end
  end

  def artists_photographs_by_age(artist)
    find_photographs_by_artist(artist).reduce({}) do |hash, photo|
      hash[photo.year.to_i - artist.born.to_i] = photo.name
      hash
    end
  end
end
