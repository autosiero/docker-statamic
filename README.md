# Docker configurations for Laravel Statamic

Easily simulate a dev enviroment for your developers, without being bound by
platforms (and without using Laravel Homestead or Laravel Valet).

## Features

- PHP image running on Apache with extensive addon support and Brotli
  compression (for best-result speed checks).
- Laravel Horizon for automatic job running
- Redis for caching and jobs
- Mailhog to test mails (auto-configured, just go to `/mailhog/`)

Note that the Laravel Horizon image will always crash if you don't have it
installed, which is normal (of course).

## Requirements

- Docker and Docker Compose
- Bash (for the `install` script)

If you don't want to build the images, but rather pull the pre-built ones from
GitHub, you'll need a [packages access token][token-1] and [log in to GitHub
Packages][token-2]

[token-1]: https://github.com/settings/tokens/new?scopes=read:packages&description=GitHub+Packages+read-only+access
[token-2]: https://help.github.com/en/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages#authenticating-to-github-packages

## Quick installation

1. Add the project as a submodule to your Statamic project
   ```
   git submodule add https://github.com/autosiero/docker-statamic.git .docker
   ```
2. Install the `docker-compose.yml` and `docker-compose.override.yml` files
   ```
   ./docker/install
   ```
3. (optional) configure different ports using `docker-compose.override.yml`
4. Start your containers
   ```
   docker-compose up -d
   ```
5. Visit your Statamic site
   https://localhost:8080

## Regular install

1. Add the project as a submodule to your Statamic project
   ```
   git submodule add https://github.com/autosiero/docker-statamic.git .docker
   ```
2. Symlink `./docker-compose.yml` in your project to
   `.docker/docker-compose.yml`
3. Copy `.docker/docker-compose.override.yml` to
   `./docker-compose.override.yml`
4. Modify `./docker-compose.override.yml` as you see fit
5. Start the thing `docker-compose up -d`
6. Go to http://localhost:8080 (change `8080` if you changed the ports)

## Licensed

Licensed under [MIT](./LICENSE.md).
