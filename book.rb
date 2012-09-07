require 'pdfkit'
require 'redcarpet'

module Book
  ASSETS_DIR = File.join(File.dirname(__FILE__), "assets") 
  BOOK_DIR = File.join(File.dirname(__FILE__), "book")
  OUTPUT_DIR = File.join(File.dirname(__FILE__), "output")

  def build(pdf=false)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                             #:no_links => true,
                             :space_after_headers => true,
                             :with_toc_data => true,
                             :fenced_code_blocks => true)
    toc_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML_TOC)
    doc = toc_renderer.render(complete_markdown(true))
    doc << renderer.render(complete_markdown)
    if pdf
      kit = PDFKit.new(doc, :page_size=>'Letter')
      kit.stylesheets << "#{ASSETS_DIR}/book.css"
      pdf = kit.to_pdf
      mkdir_p OUTPUT_DIR
      file = kit.to_file("#{OUTPUT_DIR}/sinatra-book.pdf")
    end
    return doc
  end

  private
  def complete_markdown(toc=false)
    s = []
    File.new("book-order.txt").each_line do |line|
      line.strip!
      next if line =~ /^#/   # Skip comments
      next if line =~ /^$/   # Skip blank lines
      File.open(File.join(BOOK_DIR, line)) do |f|
        s << f.read
      end
    end
    return s.join("\n\n* * *\n\n")
  end
end
