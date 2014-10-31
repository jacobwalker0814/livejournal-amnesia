# LiveJournal Amnesia

One day my spouse says to me

> Didn't you used to have a LiveJournal?

Yes. Yes I did. I went diving through the internet pipes and found that blast
from the past. What I read there... well I don't want to talk about it. In
fact, I don't want anyone to talk about it. To that end, I created *LiveJournal
Amnesia!*

This project provides a simple command `forget` which uses the [livejournal
gem](https://github.com/romanbsd/livejournal) to fetch all of your posts and
mark them as private. A more thorough purging would delete the posts but I
figured I might want them some day so instead we'll just repress them like bad
memories and never bring them up in polite company.

## To Forget

1. clone this repo
2. cd into it
3. run `bundle install`
4. Copy the `.env.example` file to `.env` then replace the defaults with  your
   LiveJournal username and password
5. Run `./forget`

## Encoding Problems
At some point in the mid/late 2000's LiveJournal standardized all posts to
Unicode. Prior to that the encoding of posts was unknown. It is possible that
the LiveJournal API will refuse to serve you posts if it doesn't know what
encoding to use. You can fix this by:

1. Log in to LiveJournal in a web browser
2. Go to the [OldEncoding Settings Page](http://www.livejournal.com/settings/?c=OldEncoding)
3. Set the default encoding to something reasonable for you. If you don't know
   which one to pick just use "Western European (ISO)"
