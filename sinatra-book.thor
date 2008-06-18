# module: sinatra-book

require 'rubygems'
require 'maruku'

require 'fileutils'

class Book < Thor
  
  SUPPORTED_FORMATS = %w{html latex pdf}
  OUTPUT_DIR = "#{__FILE__}/output/"
  BOOK_FILE_NAME = "sinatra-book"

  desc "build [FORMAT]", "Build the book. FORMAT specifies what format the output should have. Defaults to html. Valid options are: #{SUPPORTED_FORMATS.join(", ")}"
  def build(format = 'html')
    doc = Maruku.new(complete_markdown)
    
    FileUtils.mkdir_p(OUTPUT_DIR)
    
        
    if SUPPORTED_FORMATS.include?( format )
      self.send("build_#{format}")
    else
      STDERR << "Error: Don't know how to build for format '#{format}'"
      exit 1
    end
    
  end
  
  private
  
  
  def build_html(doc)
    File.open(OUTPUT_DIR + BOOK_FILE_NAME + '.html', 'w+') do |file|
      file << doc.to_html_document
    end
  end
  
  def build_latex(doc)
    File.open(OUTPUT_DIR + BOOK_FILE_NAME + '.tex', 'w+') do |file|
      file << doc.to_latex_document
    end
  end
  
  def build_pdf(doc)
    build_latex(doc)
    
    # Run twice to get cross-references right
    2.times { system("pdflatex #{OUTPUT_DIR + BOOK_FILE_NAME + '.tex'} -output-directory=#{OUTPUT_DIR}") }
    
    # Clean up
    file_patterns = %w{*.aux *.out *.toc}
    Dir.chdir(OUTPUT_DIR) do |dir|
      file_patterns.each do |pattern|
        FileUtils.rm( Dir.glob(pattern))
      end
    end
  end
  
  def complete_markdown
    # Collect all the markdown files in the correct order and squash them together into one big string
    "A markdown string"
  end

end
