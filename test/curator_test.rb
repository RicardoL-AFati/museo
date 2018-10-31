require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/photograph'
require './lib/curator'

class CuratorTest < Minitest::Test
  def setup
    @photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }

    @rue = Photo.new(@photo_1)

    @photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    @moonrise = Photo.new(@photo_2)

    @artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }

    @henri = Artist.new(@artist_1)

    @artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    @ansel = Artist.new(@artist_2)

    @curator = Curator.new
  end

  def test_it_has_no_artists_to_start
    assert_empty @curator.artists
  end

  def test_it_has_no_photographs_to_start
    assert_empty @curator.photographs
  end

  def test_it_can_add_an_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    expected = [@henri, @ansel]
    result = @curator.artists

    assert_equal expected, result
    assert_equal @henri, @curator.artists.first
    assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
  end

  def test_it_can_find_artist_by_id
    assert_equal @henri,
    curator.find_artist_by_id("1")
  end

  def test_it_can_add_a_photograph
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    expected = [@rue, @moonrise]
    result = @curator.photographs

    assert_equal expected, result
    assert_equal @rue, @curator.artists.first
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)",
    @curator.photographs.first.name
  end

  def test_it_can_find_photograph_by_id
    assert_equal @henri,
    curator.find_artist_by_id("1")
  end
end
