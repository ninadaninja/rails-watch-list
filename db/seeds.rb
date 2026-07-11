require "open-uri"
require "json"

Bookmark.destroy_all
Movie.destroy_all
List.destroy_all

puts "Database cleaned!"
url = "https://tmdb.lewagon.com/movie/top_rated"

movies = JSON.parse(URI.open(url).read)

movies["results"].each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end

puts "#{Movie.count} movies created!"
