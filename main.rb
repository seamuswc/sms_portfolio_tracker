require_relative "coin"
require_relative "nft"
require_relative "files"
require_relative "sms"

@coin = Coin.new
@nft = NFT.new
@sms = SMS.new

$thr = []

def start() 
    if($thr.length >=1)
        puts "Loop already running"
        return
    end
    puts "starting sms program......"
    $thr << Thread.new { 
        while true
            time = Time.new
            if time.hour == 12
                @sms.send(@coin.run)
                puts "coin sms sent"
                sleep(5)
                @sms.send(@nft.run)
                puts "nft sms sent"
            end
            sleep(3600)
        end
    }
end

def stop()
    if $thr.length >= 1
        Thread.kill($thr.first)
        $thr.pop
    end
    puts "hopefully succesfully eneded sms program....."
end

def list_commands()
    puts ""
    puts "add coin       : appends coin to list"
    puts "delete coin    : delete coin from list"
    puts "list coin      : reads coin list"
    puts "add nft        : appends nft to list"
    puts "delete nft     : delete nft from list"
    puts "list nft       : reads nft list"
    puts "threads        : thread count check"
    puts "test           : sends an sms of coins"
    puts "start          : starts the sms program"
    puts "stop           : stops sms thread"
    puts "exit           : will exit any command or the program"
    puts ""
end

def command(arg)
    case arg
    when "add coin"
        Files.new('coin').append_list
    when "delete coin"
        Files.new('coin').delete_from_list
    when "list coin"
        Files.new('coin').print_list
    when "add nft"
        Files.new('nft').append_list
    when "delete nft"
        Files.new('nft').delete_from_list
    when "list nft"
        Files.new('nft').print_list
    when "start"
        start
    when "stop"
        stop
    when "test"
        @sms.send(@coin.run)
        puts "sent sms"
    when "threads"
        puts $thr.count
    when "help"
        list_commands
    when "exit"
        exit(true)
    else
        puts "command not found"
    end
end

while true
    command(gets.chomp)
end

