# Marley Spoon challenge

![Build and test](https://github.com/johnjocoo/effective-octo-umbrella/actions/workflows/test.yml/badge.svg)
![Deployed to Fly.io](https://github.com/johnjocoo/effective-octo-umbrella/actions/workflows/main.yml/badge.svg)

## Developing

Requires Elixir >= 1.13 and OTP >= 24

To start your development server:

  * Install dependencies with `mix deps.get`
  * Decrypt your secrets with `mix secrex.decrypt` - you will be prompted for key, use `uybs87rg78w34bg73qwv87w3b4v8` (provided just for challenge review)
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Releasing 

Docker image is build by GH actions on commit to main.

You can build it yourself by:

    docker build --build-arg MARLEY_SECRETS_KEY=_secret_key_ .

Alternatively you can build an Elixir/Erlang release with

    mix deps.get --only prod
    mix secrex.decrypt (provide secret_key)
    mix deps.compile
    mix assets.deploy
    mix compile
    mix release

## Deploying

After Docker image build by GH pipeline, it is deployed to [Fly.io](https://fly.io/)

You can deploy it yourself with fly.io cli tools

    fly deploy --build-arg MARLEY_SECRETS_KEY=_secret_key_

Please note that on first deploy to Fly.io you will need to create an app on platform

    fly launch --no-deploy
