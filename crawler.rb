require 'kimurai'

class OCWSpider < Kimurai::Base
  @name = "ocw_spider"
  @engine = :selenium_firefox
  @start_urls = ["https://ocw.mit.edu/search/?f=Lecture%20Videos"]
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    before_request: { delay: 4..7 }
  }

  def parse(response, url:, data: {})
    search_result_path = '//div[@class="card-contents"]/div[contains(@class,"search-result")]'
    count = response.xpath(search_result_path).count

    loop do
      browser.execute_script("window.scrollBy(0, 10000)") ; sleep 2
      response = browser.current_response

      new_count = response.xpath(search_result_path).count
      if count == new_count
        logger.info "> Pagination is done. Crawling individual pages..." and break
      else
        count = new_count
        logger.info "> Continue scrolling, current count is #{count}..."
      end
    end

    response.xpath('//div[@class="lr-row course-title"]/a').each do |a|
      request_to :parse_course_page, url: absolute_url(a[:href], base: url)
    end
  end

  def parse_course_page(response, url:, data: {})
    course = {}

    course[:url] = url

    course[:title] = response.xpath('//div[@id="course-banner"]/div/h1/a').text
    instructors = response.xpath('//div[@class="course-info-content "]//a[contains(@class, "course-info-instructor")]').map(&:text).join(", ")
    course[:instructors] = instructors
    topics = response.xpath('//ul[@class="list-unstyled pb-2 m-0 "]//a[contains(@class, "course-info-topic")]').map(&:text).join(", ")
    course[:topics] = topics
    course[:departments] = response.xpath('//div[@class="course-info-content "]//a[contains(@class, "course-info-department")]').map(&:text).join(", ")
    course[:resource_types] = response.xpath('//div[@class="learning-resource-type-item"]//div/span').map(&:text).join(", ")

    term_text = response.xpath('//span[@class="course-number-term-detail"]').text
    term_detail = term_text.split(' | ')
    id = term_detail[0]
    date = term_detail[1]
    level = term_detail[2]

    year = date.match(/(20\d{2})/)
    course[:year] = year[1] if year
    course[:id] = id
    course[:date] = date
    course[:level] = level

    return unless unique?(:term_text, term_text)

    logger.info "> Saved #{id}"

    save_to "results.csv", course, format: :csv, position: false
  end
end

puts "> Crawl started. Please be patient..."
OCWSpider.crawl!
