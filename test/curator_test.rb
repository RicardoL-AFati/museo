require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'

class CuratorTest < Minitest::Test
  def setup
    @photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }

    @rue = Photograph.new(@photo_1)

    @photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    @moonrise = Photograph.new(@photo_2)

    @photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }

    @twins = Photograph.new(@photo_3)

    @photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }

    @child = Photograph.new(@photo_4)

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

    @artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    @diane = Artist.new(@artist_3)

    @walker = Artist.new({
      id: "4",
      name: "Walker Evans",
      born: 1903,
      died: 1975,
      country: "United States"
    })

    @manuel = Artist.new({
      id: "5",
      name: "Manuel Alvarez Bravo",
      born: 1902,
      died: 2002,
      country: "Mexico"
    })

    @bill = Artist.new({
      id: "6",
      name: "Bill Cunningham",
      born: 1929,
      died: 2016,
      country: "United States"
    })

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

    assert_equal @henri, @curator.artists.first
    assert_equal @ansel, @curator.artists[1]
    assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
  end

  def test_it_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal @henri,
    @curator.find_artist_by_id("1")
  end

  def test_it_can_add_a_photograph
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal @rue, @curator.photographs.first
    assert_equal @moonrise, @curator.photographs[1]
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)",
    @curator.photographs.first.name
  end

  def test_it_can_find_photograph_by_id
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    assert_equal @moonrise,
    @curator.find_photograph_by_id("2")
  end

  def test_it_find_photographs_by_artist
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    diane = @curator.find_artist_by_id("3")
    expected = [@twins, @child]
    result = @curator.find_photographs_by_artist(diane)

    assert_equal expected, result
  end

  def test_it_finds_artists_with_multiple_photographs
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    assert_equal [@diane], @curator.artists_with_multiple_photographs
  end

  def test_photographs_taken_by_artists_from_returns_empty_when_no_matches
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    assert_empty @curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_returns_photographs_taken_by_artists_from_a_country
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)

    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    assert_equal [@moonrise, @twins, @child],
    @curator.photographs_taken_by_artists_from("United States")
  end

  def test_it_can_load_photos_from_csv
    @curator.load_photographs('./data/photographs.csv')

    expected = [@rue, @moonrise, @twins, @child]
    result = @curator.photographs

    assert_equal expected, result
  end

  def test_it_can_load_artists_from_csv
    @curator.load_artist('./data/artists.csv')

    expected = [@henri, @ansel, @diane, @walker, @manuel, @bill]
    result = @curator.artists

    assert_equal expected, result
  end
end
