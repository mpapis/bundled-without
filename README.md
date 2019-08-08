# BUNDLED WITH'OUT

Force [bundler](https://bundler.io) to not generate the `BUNDLED WITH` part of `Gemfile.lock`. 

## Why?

Because we can, and I do not like the `BUNDLED_WITH` - @mpapis

## Contributing

Open a PR, tests it with bundler before 2.1 and since 2.1 as it changes `require` to `relative_require`.
