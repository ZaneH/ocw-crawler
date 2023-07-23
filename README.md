# MIT OpenCourseWare Crawler

- [Google Sheet: OCW Video Lectures](https://docs.google.com/spreadsheets/d/11xrcKgfHNXws-YNMKpmcPBZ0a59npcmkl8-zxbv61CI/edit?usp=sharing)
    - **Last updated**: July 24, 2023

## Description

This is a simple crawler to export the available courses on [MIT OpenCourseWare](https://ocw.mit.edu/). The crawler will export the courses with video lectures as a CSV file.

By changing the `@start_urls` in `crawler.rb` you can crawl for different courses.

## Setup

Install Ruby 2.5.0 and `kimurai` gem. You may also need to `brew install --cask chromedriver` or install Google Chrome. Read more about setting up `kimurai` [here](https://github.com/vifreefly/kimuraframework#installation).

```bash
$ gem install kimurai
```

## Run

Running the program will override the `results.csv` file. Takes ~25min to crawl all of the video courses. There is a 4 to 7 second delay between each request for politeness.

```bash
$ ruby crawler.rb
...
```