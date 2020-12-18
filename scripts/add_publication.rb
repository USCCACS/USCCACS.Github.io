require 'nokogiri'

# input file which contains the data for the publication
DATA_FILENAME = "publication_details.xml"
OUTPUT_FILENAME = "test_page.html"

def find_data_file(data_files)
  unless (data_files.map { |f| File.exist?(f) }.include? false)
    puts "files exists. we will now begin processing for valid contents"
  else
    abort "Both files #{data_files} must be present in the root directory. 
    This action fails" 
  end
end

def read_data_and_prepend(data_filename, output_filename)
  # pre-check for existing input and output files
  find_data_file([data_filename, output_filename])
  
  puts "checking for valid entries"
  xml_doc = File.open("publication_details.xml") { |f| Nokogiri::XML(f) }
  sitcom1 = xml_doc.css('sitcom')
  puts "this is the first sitcom"+sitcom1[0].to_xml
  sitcoms = xml_doc.css('sitcoms')
  sitcom1.each {|b| puts b.to_xml } 
  # puts xml_doc.to_XML
end

read_data_and_prepend(DATA_FILENAME, OUTPUT_FILENAME)
  
