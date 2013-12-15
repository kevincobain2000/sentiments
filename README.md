# Sentiments

Simple and Faster Sentiment Classifier categorizes sentence into positive & negative.
Tries to handle negation

## Demos

- [Online Demo Sentiment Classifier]
- [Online Demo Sentiment Classifier Live Tweets Analysis]

[Online Demo Sentiment Classifier]: http://www8355ue.sakura.ne.jp/?action_classifiers_sentiment=true

[Online Demo Sentiment Classifier Live Tweets Analysis]: http://www8355ue.sakura.ne.jp/?action_classifiers_twitter=true

## Installation

Add this line to your application's Gemfile:

    gem 'sentiments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sentiments

## Usage

```
require 'sentiments'
puts sentiments.score("nice movie")
```

## To Do

Complete data word list

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
