require 'nokogiri'

DATA_FILENAME = "publication_details.xml"
OUTPUT_FILENAME = "wp_index.html"
@required_fields = ['title', 'author', 'publisher', 'rating', 'volume', 'year', 'link']

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
      field_content = publication.at_css(field).content
      empty_child << (field_content.empty? || field_content == " ")
    end
    
    unless empty_child.include?(true)
      valid_nodes << true
    else 
      valid_nodes << false
    end  
    
    # warn the user in the case of in-complete fill-up of details
    if (empty_child.include?(true) and empty_child.include?(false))
      abort ("Some fields were found to be incomplete")
    end
  end
  valid_nodes
end

def get_year_node(all_years, target_year)
  year_node = []
  
  # find the smallest year, close to target year and add previous sibling
  located_year = all_years.select {|year| year.content <= target_year }
  
  if (located_year.empty?)      
    year_node = @html_doc.css('div ol')[0].add_child "<h2>#{target_year}</h2>"
  else
    if (located_year.first.content == target_year)
      year_node << located_year.first
    else
      year_node = located_year.first.add_previous_sibling "<h2>#{target_year}</h2>"
    end    
  end
  
  year_node
end

def prepend_to_html(publication, output_filename)
  
  entry_builder = Nokogiri::HTML::Builder.new do |html|
    html.li {
      html.a(:href => publication.at_css(@required_fields[6]).content) {
        html.text publication.at_css(@required_fields[0]).content }
      html.br 
      html.text publication.at_css(@required_fields[1]).content
      html.br
      html.i publication.at_css(@required_fields[2]).content
      html.b publication.at_css(@required_fields[3]).content
      html.b ","+publication.at_css(@required_fields[4]).content
      html.text "("+publication.at_css(@required_fields[5]).content+")"
    }
  end
  
  all_years = @html_doc.css('div ol h2')
  # puts all_years
  year = get_year_node(all_years, publication.at_css('year').content)  
  
  year[0].add_next_sibling entry_builder.to_html
  
  # set the content of transfered data to empty  
  @required_fields.each do |field|
    publication.at_css(field).content = " "
  end

end

def read_data_and_prepend(data_filename, output_filename)
  # pre-check for existing input and output files
  ensure_data_files([data_filename, output_filename])
  
  @xml_doc = File.open(data_filename) { |f| Nokogiri::XML(f) }
  @html_doc = File.open(output_filename) {|f| Nokogiri::HTML(f) }
  
  # check if any all valid publication details are provided
  publications = @xml_doc.css('publications publication')
  valid_nodes = identify_valid_nodes(publications)
  # p valid_nodes
  publications.zip(valid_nodes).each_entry { |pub, valid| 
    if (valid) then prepend_to_html(pub, output_filename) end
  }
  # puts @html_doc
#   puts @xml_doc
  File.write(output_filename, @html_doc.to_html)
  File.write(data_filename, @xml_doc.to_xml)
end

read_data_and_prepend(DATA_FILENAME, OUTPUT_FILENAME)
  
