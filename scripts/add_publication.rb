require 'nokogiri'

# input file which contains the data for the publication
DATA_FILENAME = "publication_details.xml"
OUTPUT_FILENAME = "test_page.html"
@required_fields = ['title', 'author', 'rating', 'volume', 'year']

def find_data_file(data_files)
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
    
    # warn the user in the case of im-complete fill-up of details
    if (empty_child.include?(true) and empty_child.include?(true))
      abort ("Some fields were found to incomplete")
    end
  end
  
  valid_nodes
end

def read_data_and_prepend(data_filename, output_filename)
  # pre-check for existing input and output files
  find_data_file([data_filename, output_filename])
  
  puts "Checking for valid entries"
  xml_doc = File.open(data_filename) { |f| Nokogiri::XML(f) }
  
  # check if any all valid publication details are provided
  publications = xml_doc.css('publications publication')
  valid_nodes = identify_valid_nodes(publications)
  p valid_nodes
  # puts publications
  # sitcom1 = xml_doc.css('sitcom')
  # puts "this is the first sitcom"+sitcom1[0].to_xml
  # sitcoms = xml_doc.css('sitcoms')
  # sitcom1.each {|b| puts b.to_xml }
  # puts xml_doc.to_XML
end

read_data_and_prepend(DATA_FILENAME, OUTPUT_FILENAME)
  
