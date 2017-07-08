# Project 4 - *Twitter*

**Twitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User sees app icon in home screen and styled launch screen
- [X] User can sign in using OAuth login flow
- [X] User can Logout
- [X] User can view last 20 tweets from their home timeline
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [X] User can pull to refresh.
- [X] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [X] User can compose a new tweet by tapping on a compose button.
- [X] Using AutoLayout, the Tweet cell should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation.
- [X] The current signed in user will be persisted across restarts

The following **optional** features are implemented:

- [ ] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [X] User can view their profile in a profile tab
- [X] User should display the relative timestamp for each tweet "8m", "7h"
- [X] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [ ] Links in tweets are clickable
- [ ] User can tap the profile image in any tweet to see another user's profile
- [X] Contains the user header view: picture and tagline
- [X] Contains a section with the users basic stats: # tweets, # following, # followers
- [X] Profile view should include that user's timeline
- [ ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [X] When composing, you should have a countdown in the upper right for the tweet limit.
- [X] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet
- [X] Profile view should include that user's timeline
- [ ] Pulling down the profile page should blur and resize the header image.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1.  How can we do all the neat animations Twitter does in the profile view?
2.  How can we implement the burger view with similar style to twitter's?

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/NsRSVVH.gif' title='1' width='' alt='4' />

<img src='http://i.imgur.com/e6DVDto.gif' title='2' width='' alt='4' />

<img src='http://i.imgur.com/ElZvyoO.gif' title='3' width='' alt='6' />

<img src='http://i.imgur.com/exzHlln.gif' title='7' width='' alt='8' />


GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Had trouble with unfavoriting and unretweeting.

## Credits

3rd party libraries, icons, graphics, or other assets used in Twitter:

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

Copyright [2017] [Chase Warren]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
