require 'nokogiri'

DATA_FILENAME = "publication_details.xml"
OUTPUT_FILENAME = "test_page.html"
@required_fields = ['title', 'author', 'rating', 'volume', 'year', 'link']

def ensure_data_files(data_files)
  unless (data_files.map { |f| File.exist?(f) }.include? false)
    puts "Files exist. We will now begin processing for valid contents."
  else
    abort "Both files #{data_files} must be present in the root directory. 
    This action fails" 
  end
end

def identify_valid_nodes(publications)
  valid_nodes = []
  
  publications.each do |publication|
    empty_child = []
    
    @required_fields.each do |field|
      empty_child << publication.at_css(field).content.empty?
    end
    
    unless empty_child.include?(true)
      valid_nodes << true
    else 
      valid_nodes << false
    end  
    
    # warn the user in the case of in-complete fill-up of details
    if (empty_child.include?(true) and empty_child.include?(true))
      abort ("Some fields were found to incomplete")
    end
  end
  valid_nodes
end

def prepend_to_html(publication, output_filename)
  all_dates = @html_doc.css('div ol h2')
  # puts all_dates
  date = all_dates.select {|d| d.content==publication.at_css('year').content }
  if !(date.empty?) then puts "year exists" 
  else puts "year must be added"
  end
  # p date
  # date_value = date.add_next_sibling "<li>my head</li>"
  # puts @html_doc
  # @required_fields.each do |field|
#     puts publication.at_css(field).content
#
#     # set the content of transfered data to empty
#   end

#  publication.css('year').each {|p| p.add_child '<extra>head</extra>'}
#  puts publication
 # puts @xml_doc
end

def read_data_and_prepend(data_filename, output_filename)
  # pre-check for existing input and output files
  ensure_data_files([data_filename, output_filename])
  
  @xml_doc = File.open(data_filename) { |f| Nokogiri::XML(f) }
  @html_doc = File.open(output_filename) {|f| Nokogiri::HTML(f) }
  
  # check if any all valid publication details are provided
  publications = @xml_doc.css('publications publication')
  valid_nodes = identify_valid_nodes(publications)
  p valid_nodes
  publications.zip(valid_nodes).each_entry { |pub, valid| 
    if (valid) then prepend_to_html(pub, output_filename) end
  }
  
  # @xml_doc.write_to(output_filename)
end

read_data_and_prepend(DATA_FILENAME, OUTPUT_FILENAME)
  
