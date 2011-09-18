require 'retrieval/uri'

class RetrievalHelper
    def self.retrieve url
        URI.parse(url).open
    end

    def self.create_attribute_map model_class, header_data, financial_data
        attribute_map = {}
        for index in 0..(header_data.size-1)
            column = model_class.column_associations[header_data[index].strip]
            attribute_map[column] = financial_data[index] if !column.nil?
        end
        return attribute_map
    end

    def self.extract_leaf node
        while  !node.nil? and !node.at("/").nil?
            node = node.search("/").find{|node| !node.to_s.strip.eql?("")}
        end
        node.to_s.strip.gsub("?", "").gsub(",","")
    end
end