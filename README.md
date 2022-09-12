
## Sends an SMS of your portfolio at set intervals

###### Step 1 Create a .env file for your nexmo/vonage api keys

VONAGE_API_KEY = ""

VONAGE_API_SECRET = ""

VONAGE_BRAND_NAME = ""

TO_NUMBER = "+"

###### Step 2 - Create an account to get your api keys at: https://www.vonage.com

###### Step 3 - 'bundle install' to install needed gems, 'ruby main.rb' to start program

###### Step 4 - 'help' to view the commands

###### Step 5 - recommend using 'tmux' if running through a ssh connection

## BUGS / NOTES

The program pulls its api data from www.coingecko.com.
Because of this, when enetering the coin name you must use the api token name provided by coingecko.

If you would like to add bitcoin, the api name is 'bitcoin'.
However for Synthetix it is 'havven'.

There is no error checking and wrong api tags will crash the program.



## License

This project is licensed under the MIT License
