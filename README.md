#Fantasy Sports Calculator


This is a Ruby application that will store scoring rule for multiple fantasy leagues, collect the stats of a player by position, and then outputs the score that that player will get for each league that you are in.

###Features

This app will allow you to create, view, delete, edit, and store multiple fantasy league scoring rules. You can then enter in a player and and you will receive the fantasy score for each league you have. The score is calculated for each league from the stat line of whatever game you choose. Statistics are provided by a python package called [nflgame](https://github.com/BurntSushi/nflgame) by [BurntSushi](https://github.com/BurntSushi)

Allows user id and password protection. Each user can have multiple leagues stored. User login will pull up leagues table specific to that user.

###Instructions

You must have Ruby 2.0.0, Python 2.7 minimum, and bundler gem installed.<br />
For instructions on installing Ruby [click here](http://www.ruby-lang.org/en/downloads/).<br />
For instructions on installing Python [click here](http://wiki.python.org/moin/BeginnersGuide/Download).<br />
Once you install Ruby and Python you will need to install the bundler gem.

`gem install bundler`

Then navigate to the Fantasy Calculator directory and run bundler to install all necessary gems.

`bundle`

To start the application 

`ruby fantasycalculator.rb`

then follow the on-screen promts and enjoy!




##Phase 1 complete


I am currently planning and drawing out the branching structure of this program and the use of Active Record. After I have finished planning I will begin creating implementation and unit tests.

##Phase 2 complete

Setting up the sqlite database and migrations. Command line interface of the app is being built and features are being implemented.

##Phase 3 complete

Interface is built and app is able to create and edit league records.

##Phase 4 complete

Created users table and functionality to allow logins and password authetication. Users can only access the leagues that they have created.

##Phase 5 complete

Implemented [nflgame](https://github.com/BurntSushi/nflgame) and app is able to access game stats by collecting the player name, year, and week from the user (Tom Brady 2012
week 4). Nflgame then searches for stats and outputs them as a string. App then takes string and converts it into a hash for score calculation. Main functionality is now complete!

##Bugs

Some of the bugs that I have found are as follows:
    <ul>
    <li>nflgame searches for players using the players first initial, period, and last name (Frank Gore = F.Gore). The problem with this is that sometimes two player have the same first initial and last name (Chris Johnson and Calvin Johnson). This could cause nflgame to output the stats for the wrong player.</li>
    </ul>
Please help by reporting any bugs or issues that you find.

##Future

I would like to expand this app to include all fantasy sports as well as stat collection for all of those corresponding sports. Also I am currently planning on creating a graphical interface for web use and a possible mobile app.



#Copyright

zero....
I need a lawyer
