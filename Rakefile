require File.join(File.dirname(__FILE__), "book.rb")

namespace :book do
  desc "build the book into pdf"
  task :build do
    include Book
    build(true)
  end
end
