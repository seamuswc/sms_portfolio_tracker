require 'uri'
require 'net/http'
require 'openssl'
require 'json'


class NFT

    def api(nft, amount) 
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
            price = parsed["collection"]["stats"]["floor_price"].to_f
        else
            puts "couldnt find nft"
        end

        price =  price * amount.to_i
        return "#{amount} #{nft} is: #{price} ETH. \n"

    end

    def run
        sms_text = ""
        file = File.read('nft.json')
        data_hash = JSON.parse(file)
        data_hash.each do |k,v| 
            sms_text << api(v[0], v[1])
        end
        return sms_text
    end

end #end class