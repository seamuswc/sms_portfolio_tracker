require 'json'


class Files

    def initialize(type)
        @fileName = "./#{type}.json"
    end

    def print_list()
        file = File.read(@fileName)
        data_hash = JSON.parse(file)
        data_hash.each do |k,v| 
            puts "#{v}"
        end
    end

    def delete_from_list()
        file = File.read(@fileName)
        data_hash = JSON.parse(file)
        data_hash.each do |k,v| 
            puts "#{k}: #{v}"
        end

        puts "Select by number to delete or type 'none' to exit\n"
        nft = gets.chomp

        if nft == "none" || nft == "exit" then return end

        int = nft.to_i

        if int == 0 then return end
        if int > 0 and int <= data_hash.size then
            data_hash.delete(nft)
            
            
            #re-order it
            j = {}
            i = 1
            data_hash.each do |k,v| 
                j[i] = v
                i+=1
            end



            File.write(@fileName, JSON.dump(j))
        end

    end

    def append_list()
        puts "What would you like to add?\n"
        nft = gets.chomp
        puts "how many?\n"
        num = gets.chomp
        if nft == "none" || nft == "exit" then return end
        file = File.read(@fileName)
        data_hash = JSON.parse(file)
        size = data_hash.size + 1
        data_hash[size] = [nft, num]
        File.write(@fileName, JSON.dump(data_hash))
    end


end #end class