# MIT OpenCourseWare Crawler

## Crawl Output

**Last updated**: July 24, 2023

- OCW Video Lectures: [results.csv](https://github.com/ZaneH/ocw-crawler/blob/main/results.csv)

## Description

This is a simple crawler to save the available courses on [MIT OpenCourseWare](https://ocw.mit.edu/). This crawler will export the courses with video lectures as a CSV file.

You can crawl for courses other than video lectures by changing the `@start_urls` in `crawler.rb`.

## Docker Run (Recommended)

This is the simplest way to run the crawler. It will run the crawler and save the results in `results.csv` using a Docker volume. 

```bash
$ docker build -t ocw-crawl:1.0 .
$ docker run --volume $(pwd)/results.csv:/app/results.csv \
             --rm \
             --name ocw-crawl \
             ocw-crawl:1.0
```

---

## Manually Run

To run the crawler without Docker, you'll need to install an older version of Ruby that's compatible with `kimurai`. You'll also need `geckodriver` and Firefox. Read more about setting up `kimurai` [here](https://github.com/vifreefly/kimuraframework#installation) if you run into trouble.

### Setup

Install Ruby 2.5.0 and run `bundle install`.

```bash
$ asdf install ruby 2.5.0
$ asdf global ruby 2.5.0
$ gem install bundler
$ bundle install # install dependencies
```

### Run

```bash
$ ruby crawler.rb
...
```