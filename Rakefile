require "open-uri"
require 'erb'

namespace :v1 do
  desc 'v1初期化 InDesign CS - CS5'
  task :init do
    @ver = "1"
    @cmd = "wget -r http://indesign.cs5.xyz/iddomjs/domCS-CS55.html"
    @src = "sources_v1"
    @dom = "iddomjs_v1"
  end
end

namespace :v2 do
  desc 'v2初期化 InDesign CS5 - CC2015 beta'
  task :init do
    @ver = "2"
    @cmd = "wget -r http://indesign.cs5.xyz/dom/domtree.html"
    @src = "sources_v2"
    @dom = "iddomjs_v2"
  end
end

# directory @src

desc "ページのダウンロード"
task :download do
  system @cmd
  system "mv indesign.cs5.xyz/ #{@src}"
end

desc "HTMLの変換"
task :convert_html do
  if @ver == "1"
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
  elsif @ver == "2"
    Dir::glob("#{@src}/dom/*.html") do |html|
      open(html,"r" ) do |f|
        conv = f.read
          .gsub('<base target="_blank">', "")
          .gsub(/\<body\>/i, "<body><form accept-charset='utf-8' action='/search' method='post'><label><input name='search' type='text' value=''><input type='submit' value='search'></label></form>")

        open(File.join(@dom, File.basename(html)), "wb") do |out|
          out.write(conv)
        end
      end
    end
  end
end

desc '配置'
task :dest do
  rm_rf @dom
  if @ver == "1"
    cp_r(File.join(@src, 'iddomjs'), @dom)
  elsif @ver == "2"
    cp_r(File.join(@src, 'dom'), @dom)
  end
end

desc '後始末'
task :cleanup do
  rm_rf @src
end

desc 'app.rbの生成'
task :generate_app do
  File.open("./app.rb", "wb") do |f|
    f.print ERB.new(File.read("./templates/app.rb.erb")).result(binding)
  end
end

namespace :v1 do
  desc 'v1ビルド'
  task :build => [:init, :download,  :dest, :convert_html, :cleanup, :generate_app] do
  end
end

namespace :v2 do
  desc 'v2ビルド'
  task :build => [:init, :download,  :dest, :convert_html, :cleanup, :generate_app] do
    puts "BBB"
  end  
end
