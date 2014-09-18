# Metro UI CSS Rails

[Metro UI CSS][metro_ui_css] packaged for Rails asset pipeline

[metro_ui_css]: http://metroui.org.ua/

## Installation

In your Gemfile, add:

```ruby
gem 'metro_ui_css-rails'
```

## Usage

To require all Metro UI CSS modules, add the following to your application.js:


```javascript
//= require jquery
//= require jquery-ui/widget
//= require metro
```

Also add the Metro UI CSS to your application.css:

```stylesheet
/*
 *= require metro
 */
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright (c) 2013 [Kazuya Takeshima](mailto:mail@mitukiii.jp). See [LICENSE][license] for details.

[license]: LICENSE.md
