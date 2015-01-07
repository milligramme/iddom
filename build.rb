# -*- coding: utf-8 -*-
require "open-uri"
require "fileutils"
require "zip"

class Build
  DIRNAME = File.dirname(__FILE__)
  
  def initialize
    @url = "http://indesign.cs5.xyz/extra/iddomjs_CS55.zip"
    @sp_url = "http://indesign.cs5.xyz/iddomjs/SpecialCharacters.html"
    @src = "#{DIRNAME}/sources"
    @dom = "#{DIRNAME}/iddomjs"
  end
    
  def download
    Dir.mkdir @src unless File.exist?(@src)
    file_name = File.basename(@url)
    path = File.join(@src, file_name)
    open(path, 'wb') do |output|
      open(@url) do |data|
        output.write(data.read)
      end
    end
    unzip path
  end

  def convert_html
    # cp932 to utf8
    # add search form
    # remove _blank target
    # crlf to lf
    Dir::glob("#{@src}/iddomjs/*.html") do |html|
      open(html, "r:CP932:UTF-8" ) do |f|
        conv = f.read
          .encode("UTF-16BE", "UTF-8", :invalid => :replace, :undef => :replace, :replace => '?')
          .encode('UTF-8')
          .gsub('<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">','<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">')
          .gsub('<base target="_blank">', "")
          .gsub("\r\n", "\n")
          .gsub(/\<body\>/i, "<body><form accept-charset='utf-8' action='/search' method='post'><label><input name='search' type='text' value=''><input type='submit' value='search'></label></form>")
      
      
        open(File.join(@dom, File.basename(html)), "wb") do |out|
          out.write(conv)
        end
        
      end
    end
  end
  
  def download_special_char
    file_name = File.basename(@sp_url)    
    path = File.join(@dom, file_name)
    open(path, 'wb') do |output|
      open(@sp_url) do |data|
        output.write(data.read)
      end
    end
  end

  def unzip(file_path)
    Zip::File.open(File.expand_path(file_path)) do |zip_file|
      zip_file.each do |f|
        f_path = File.join(@src, f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exist?(f_path)
      end
    end
  end
    
  def clone
    FileUtils.rm_rf @dom
    FileUtils.cp_r(File.join(@src, 'iddomjs'), @dom)
  end
  
  def cleanup
    FileUtils.rm_rf @src    
  end

  def generate
    clone
    download_special_char
    convert_html
    cleanup
  end
  
end

if $0 == __FILE__
  b = Build.new
  b.download
  b.generate
end
