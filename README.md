


# SET
[![Build Status](https://travis-ci.org/archivefever/set-game.svg?branch=master)](https://travis-ci.org/archivefever/set-game)
[![Coverage Status](https://coveralls.io/repos/github/archivefever/set-game/badge.svg?branch=master)](https://coveralls.io/github/archivefever/set-game?branch=master)

## Installation instructions

After cloning the repo, run:

`bundle install`
`be rails db:create`
`be rails db:migrate`
`be rails db:seed`

A live version of this game is available [on Heroku](http://dbc-set.herokuapp.com)

## How to play:

The objective of Set is to make a set of three cards from the selection on the board.
Each card has four attributes:
-color
-shape
-number
-shading

To make a valid set, you need to look at each attribute and make sure all three cards either match that attribute OR all three cards are different on that attribute. Essentially, you never want two cards to share a particular attribute while only the third is different.






