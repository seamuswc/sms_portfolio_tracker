require 'uri'
require 'net/http'
require 'openssl'
require 'json'

$thr = []

def api(nft) 
    begin
        url = URI("https://api.opensea.io/collection/#{nft}")
        #URI? check to prevent program crash
    rescue
        puts "NFT URL not found"
        return
    end
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    res = http.request(request)

    if res.code == "200"
        parsed = JSON.parse(res.body)
        return parsed["collection"]["stats"]["floor_price"]
    else
        puts "couldnt find nft"
    end

end

def read_list()
    file = File.read('./list.json')
    data_hash = JSON.parse(file)
    x = data_hash["nfts"]
    
    x.each do |k,v| 
        puts "#{k}: #{v}"
    end

    puts "Select nft by number to see floor or type 'none' to exit\n"
    nft = gets.chomp

    if nft == "none" || nft == "exit" then return end
    
    int = nft.to_i
    if int == 0 then return end
    if int > 0 and int <= x.size then
        res = api(x[nft])
        puts res
    end

end

def print_list()
    file = File.read('./list.json')
    data_hash = JSON.parse(file)
    x = data_hash["nfts"]
    
    x.each do |k,v| 
        res = api(x[k])
        puts "#{v}: #{res}"
    end
end

def delete_from_list()
    file = File.read('./list.json')
    data_hash = JSON.parse(file)
    x = data_hash["nfts"]
    
    x.each do |k,v| 
        puts "#{k}: #{v}"
    end

    puts "Select nft by number to delete or type 'none' to exit\n"
    nft = gets.chomp

    if nft == "none" || nft == "exit" then return end

    int = nft.to_i

    if int == 0 then return end
    if int > 0 and int <= x.size then
        x.delete(nft)
        File.write('./list.json', JSON.dump(data_hash))
    end

end

def append_list()
    puts "Which nft would you like to add?\n"
    nft = gets.chomp
    if nft == "none" || nft == "exit" then return end
    file = File.read('./list.json')
    data_hash = JSON.parse(file)
    x = data_hash["nfts"]
    size = x.size + 1
    x[size] = nft
    File.write('./list.json', JSON.dump(data_hash))
end

def loop_list() 
    if($thr.length >=1)
        puts "Loop already running"
        return
    end

    puts "Loop repeat after how many seconds?\n"
    t = gets.chomp
    if nft == "none" || nft == "exit" then return end
    t = t.to_i

    $thr << Thread.new { 
        while true
            print_list
            sleep t
        end
    }
end

def stop()
    if $thr.length >= 1
        Thread.kill($thr.first)
        $thr.pop
    end
end

def list_commands()
    puts ""
    puts "add       : appends to list"
    puts "delete    : delete from list"
    puts "list      : read list and select"
    puts "l         : print full list"
    puts "loop      : print list on a time loop"
    puts "stop      : stops loop"
    puts "exit      : will exit any command or the program"
    puts ""
end

def command(arg)
    case arg
    when "add"
        append_list()
    when "delete"
        delete_from_list()
    when "list"
        read_list
    when "l"
        print_list
    when "loop"
        loop_list
    when "stop"
        stop
    when "help"
        list_commands
    when "exit"
        exit(true)
    else
        puts api(arg)
    end
end

print_list()
while true
    command(gets.chomp)
end

