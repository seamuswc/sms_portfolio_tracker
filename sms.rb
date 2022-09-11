require 'dotenv/load'
require 'vonage'


class SMS
        
    VONAGE_API_KEY = ENV['VONAGE_API_KEY']
    VONAGE_API_SECRET = ENV['VONAGE_API_SECRET']
    VONAGE_BRAND_NAME = ENV['VONAGE_BRAND_NAME']
    TO_NUMBER = ENV['TO_NUMBER']
    
    def send(text)

        client = Vonage::Client.new(
        api_key: VONAGE_API_KEY,
        api_secret: VONAGE_API_SECRET
        )

        client.sms.send(
            from: VONAGE_BRAND_NAME,
            to: TO_NUMBER,
            text: text
        )

    end

end
