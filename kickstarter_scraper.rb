# require libraries/modules here
require 'nokogiri'
require 'pry' 

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    projects[project.css("h2.bbcard_name strong a").text.to_sym] = {
      :image_link => project.css("img.projectphoto-little").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text.strip,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i,
      :location => project.css("span.location-name").text.strip,

    }
  end

  projects
end

create_project_hash