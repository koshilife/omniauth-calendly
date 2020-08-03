# OmniAuth::Calendly

[![Test](https://github.com/koshilife/omniauth-calendly/workflows/Test/badge.svg)](https://github.com/koshilife/omniauth-calendly/actions?query=workflow%3ATest)
[![codecov](https://codecov.io/gh/koshilife/omniauth-calendly/branch/master/graph/badge.svg)](https://codecov.io/gh/koshilife/omniauth-calendly)
[![Gem Version](https://badge.fury.io/rb/omniauth-calendly.svg)](http://badge.fury.io/rb/omniauth-calendly)
[![license](https://img.shields.io/github/license/koshilife/omniauth-calendly)](https://github.com/koshilife/omniauth-calendly/blob/master/LICENSE.txt)

This gem contains the [Calendly](https://calendly.com/) API v2 strategy for OmniAuth.

## Before You Begin

You should have already installed OmniAuth into your app; if not, read the [OmniAuth README](https://github.com/intridea/omniauth) to get started.

To subscribe to webhooks, you need to have a paid Premium or Pro Calendly account. All other API access mirrors the access level you have in the Calendly web app.

To register your application:

1. Go to [https://calendly.com/login](https://calendly.com/login) and log in to your Calendly account.
2. Register as a Calendly developer by [completing this form](https://calendlyquestions.typeform.com/to/ys5GCq). We’ll process your request within 1 day and email you when it’s time to complete the setup.
3. You’ll receive your Client ID and Client Secret via the password manager LastPass.
4. See our [OAuth documentation](https://calendly.stoplight.io/docs/gh/calendly/api-docs/reference/calendly-api/oauth.yaml?srn=gh/calendly/api-docs/reference/calendly-api/oauth.yaml) for a detailed authentication and authorization walkthrough.

## Using This Strategy

First start by adding this gem to your Gemfile:

```ruby
gem 'omniauth-calendly'
```

If you need to use the latest HEAD version, you can do so with:

```ruby
gem 'omniauth-calendly', :github => 'koshilife/omniauth-calendly'
```

Next, tell OmniAuth about this provider. For a Rails app, your `config/initializers/omniauth.rb` file should look like this:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :calendly, 'YOUR_CLIENT_ID', 'YOUR_CLIENT_SECRET'
end
```

## Auth Hash Example

The auth hash `request.env['omniauth.auth']` would look like this:

```js
TODO
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/koshilife/omniauth-calendly). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the omniauth-calendly project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/koshilife/omniauth-calendly/blob/master/CODE_OF_CONDUCT.md).
