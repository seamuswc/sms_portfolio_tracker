require 'coingecko_ruby'

class Coin

    def api(coin, amount) 
        client = CoingeckoRuby::Client.new
        price = client.price(coin)
        price = price[coin]["usd"].to_i
        price =  price * amount.to_i
        return price
        #return "#{amount} #{coin} is: #{price}. \n"
    end

    def run
        sms_text = ""
        total_price = 0
        file = File.read('coin.json')
        data_hash = JSON.parse(file)
        data_hash.each do |k,v| 
            coin = v[0]
            amount = v[1]
            price =  api(v[0], v[1])
            total_price += price
            sms_text << "#{amount} #{coin} is: #{price}. \n"
        end
        sms_text << "SUM: #{total_price} \n"
        return sms_text
    end

end #end class