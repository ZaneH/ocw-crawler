# MIT OpenCourseWare Crawler

## Crawl Output

- [Google Sheet: OCW Video Lectures](https://docs.google.com/spreadsheets/d/11xrcKgfHNXws-YNMKpmcPBZ0a59npcmkl8-zxbv61CI/edit?usp=sharing)
    - **Last updated**: July 24, 2023

## Description

This is a simple crawler to export the available courses on [MIT OpenCourseWare](https://ocw.mit.edu/). The crawler will export the courses with video lectures as a CSV file.

You can crawl different courses by changing the `@start_urls` in `crawler.rb`.

## Docker Run (Recommended)

This is the simplest way to run the crawler. It will run the crawler and export the results to `./results.csv` by using a Docker volume. 

```bash
$ docker build -t ocw-crawl:1.0 .
$ docker run --volume $(pwd)/results.csv:/app/results.csv \
             --rm \
             --name ocw-crawl \
             ocw-crawl:1.0
```

---

## Manually Run

To run the crawler without Docker, you'll need to install an older version of Ruby that's compatible with `kimurai`. You'll also need `chromedriver` or a similar driver installed on your system.

### Setup

Install Ruby 2.5.0 and run `bundle install`. Read more about setting up `kimurai` [here](https://github.com/vifreefly/kimuraframework#installation) if you run into trouble.

```bash
$ asdf install ruby 2.5.0
$ asdf global ruby 2.5.0
$ gem install bundler
$ bundle install
```

### Run

Running the program will override the `results.csv` file. Takes ~25min to crawl all of the video courses. There is a 4 to 7 second delay between each request for politeness.

```bash
$ ruby crawler.rb
...
```