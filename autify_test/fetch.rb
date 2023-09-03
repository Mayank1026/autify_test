# frozen_string_literal: true

require 'open-uri'
require 'fileutils'
require 'nokogiri'
require 'uri'

def fetch_and_save(url)
  begin
    uri = URI.parse(url)

    # Validate that the URI scheme is HTTP or HTTPS
    unless uri.is_a?(URI::HTTP) || (uri.is_a?(URI::HTTPS) && !uri.host.nil?)
      puts "Invalid URL: #{url}"
      return
    end

    # Sanitize the host to prevent directory traversal attacks
    safe_host = uri.host.gsub(/[^\w\.\-]/, '_')
    filename = "#{safe_host}.html"
    html_content = URI.open(url).read

    File.write(filename, html_content)

    doc = Nokogiri::HTML(html_content)
    num_links = doc.css('a').count
    num_images = doc.css('img').count

    metadata = {
      site: uri.host,
      num_links: num_links,
      images: num_images,
      last_fetch: Time.now.utc.strftime('%a %b %d %Y %H:%M UTC')
    }

    File.write("#{filename}.metadata", metadata.inspect)
    puts "Fetched #{url} and saved as #{filename}"
  rescue StandardError => e
    puts "Error fetching #{url}: #{e.message}"
  end
end

if ARGV.empty?
  puts 'No command found'
else
  if ARGV.first == '--metadata'
    ARGV.shift
    ARGV.each do |url|
      uri = URI.parse(url)

      # Validate that the URI scheme is HTTP or HTTPS
      unless uri.is_a?(URI::HTTP) || (uri.is_a?(URI::HTTPS) && !uri.host.nil?)
        puts "Invalid URL: #{url}"
        next
      end

      # Sanitize the host to prevent directory traversal attacks
      safe_host = uri.host.gsub(/[^\w\.\-]/, '_')
      filename = "#{safe_host}.html.metadata"
      if File.exist?(filename)
        metadata = File.read(filename)
        puts metadata
      else
        puts "Metadata not found for #{url}"
      end
    end
  else
    ARGV.each do |url|
      fetch_and_save(url)
    end
  end
end
