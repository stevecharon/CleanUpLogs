# CleanUpLogs
My Scripts to cleanup Logfiles from Systems because the vendor doesn't bother to

IMHO it is weird that you pay thousands of dollars, euros or such for enterprise applications
which generate tons of logfiles and the vendor does not even bother to cleanup behind them
So, after a while, the happiness about your new thingy fades because just tonight the server crashed
while happily filling your disk, Drive C no less, and says: "Well, no more disk to fill, let's wait for admin..."

Dipping my head in that waterhole for some time now, I decided to take action and cleanup for them in advance.
So I gather all the logfile-places my apps push out to and delete everything!

Well, not everything, of course. Just in case something goes wrong on the server you might want to have at least some
of these annoying logs around to tell you wtf happened
Thats what the line
    $days = 30 
is for. Keeping a month worth of logs is enough for most parts. Feel free to edit!
If you want to know what got deleted, just use the logfile of the script to see what it did.
It is all in the Powershell-Transcript in case you got the wrong folder...

These scripts your are provided as-is and while the might work for me, they might not for you.
Please test it out by providing a whatif in the cleanlogs-Function.
Every file deleted by this script is on YOU!

I am no developer by any means and the code is far from best-practice-aligned. 
Feel free to let me know of any NoNos or even ideas to enhance upon. So fork and PR at will!
