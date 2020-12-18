require 'nokogiri'

# input file which contains the data for the publication
DATA_FILENAME = "publication_details.xml"
OUTPUT_FILENAME = "index.html"

def find_publication_file(filename)
  if (File.exist?(data_filename))
    puts "xml file exists. we will now begin processing for valid contents"
  else
    abort "#{filename} does not exit in the directory. This action fails" 
  end
end

def find_valid_entries(filename)
  puts "checking for valid entries"
  xml_doc = File.open("blossom.xml") { |f| Nokogiri::XML(f) }
  
end

find_publication_file(DATA_FILE_NAME)
find_valid_entries(FILE_NAME)
  
