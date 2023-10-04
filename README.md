# Ruby Video Share
 ## Using local setup (not Docker)
### Install dependencies
1. Ruby

Make sure you have a Ruby version manager installed, could be [rbenv](https://github.com/rbenv/rbenv), [rvm](https://rvm.io/), [asdf](https://asdf-vm.com/). I prefer `asdf` because of easier installation. Install Ruby 3.0.6 using your current Ruby version manager

2. Postgresql

If you are using Ubuntu (and you should be), you can follow [this link](https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-22-04-quickstart) to install Postgresql

3.  Redis (optional)

Follow [this guide](https://redis.io/docs/getting-started/installation/install-redis-on-linux/) to install Redis to your local. ActionCable in local env does not need Redis, but it's still nice to have

### Start server
**Prerequisites**
- Switch to correct Ruby version, we are currently using Ruby 3.0.6
- Copy content from `.env.example` file to `.env` file and replace with your values. You can ignore `BOOTSTRAP`.
- For `YOUTUBE_API_KEY`, if you have one, please use it. If you do not, you can follow [this guide](https://www.magetop.com/blog/cach-lay-api-key-youtube/) to get one. If you also do not want to do that, you can follow [this form](https://forms.gle/Bw78QfMNss5a4Vt16) to use my key

**Commands**

    bundle install
    rails db:create
    rails db:migrate
    rails s


## Using Docker

If you have a strong computer and want to use Docker, good for you

**Steps:**

- You should have Docker and Docker Compose installed, if not, why are you here?
- Copy content from  `.env.example`  file to  `.env`
- For  `YOUTUBE_API_KEY`, if you have one, please use it. If you do not, you can follow  [this guide](https://www.magetop.com/blog/cach-lay-api-key-youtube/)  to get one. If you also do not want to do that, you can follow  [this form](https://forms.gle/Bw78QfMNss5a4Vt16)  to use my key
- Set `BOOTSTRAP` to `true` if it is your **first** run, if not, set it to `false`
- `docker compose build`
- `docker compose up`
