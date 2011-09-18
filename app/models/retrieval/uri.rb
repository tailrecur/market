class URI::Generic
    def open
        if (self.is_a?(URI::HTTP))
            resource = Net::HTTP.new(host, port)
            headers, data = resource.get(path)
        else
            data = ""
            File.open(host+":"+path) do |infile|
                while (line = infile.gets)
                    data << line
                end
            end
        end
        return data
    end
end