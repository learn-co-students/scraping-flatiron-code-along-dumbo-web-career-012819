require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    html = open("http://learn-co-curriculum.github.io/site-for-scraping/courses")
    doc = Nokogiri::HTML(html)
  end

  def get_courses
    doc = self.get_page
    doc.css(".post")
  end

  def make_courses
    course_list = self.get_courses
    course_list.each do |course|
      course_object = Course.new

      course_object.title = course.css("h2").text
      course_object.description = course.css("p").text
      course_object.schedule = course.css(".date").text
    end
  end

  Scraper.new.get_page
end
