require 'bundler/gem_tasks'
require 'json'

task :submodule do
  sh 'git submodule update --init' unless File.exist?('Metro-UI-CSS/README.md')
end

task :clean do
  rm_rf 'vendor'
end

desc 'Generate javascripts'
task javascripts: :submodule do
  Rake.rake_output_message 'Generating javascripts'

  javascript_dir = 'vendor/assets/javascripts'
  target_dir = "#{javascript_dir}/metro"
  mkdir_p target_dir

  paths = Dir.glob('Metro-UI-CSS/js/*.js')

  paths.each do |path|
    basename = File.basename(path)
    target_path = File.join(target_dir, basename)
    cp path, target_path
  end

  loader_source = IO.read('./vendor/assets/javascripts/metro/metro-loader.js')
  plugins_string = loader_source.match(/\Avar plugins = \[(.+)\];/m).captures.first
  plugins = plugins_string.split(',').map { |string| string.gsub(/"|'/, '').strip }
  File.open("#{javascript_dir}/metro.js", 'w') do |file|
    plugins.each do |plugin|
      file.puts "//= require metro/metro-#{plugin}.js"
    end
  end
end

desc 'Generate stylesheets'
task stylesheets: :submodule do
  Rake.rake_output_message 'Generating stylesheets'

  stylesheet_dir = 'vendor/assets/stylesheets'
  target_dir = "#{stylesheet_dir}/metro"
  mkdir_p target_dir

  paths = Dir.glob('Metro-UI-CSS/css/*.css')

  paths.each do |path|
    basename = File.basename(path)
    target_path = File.join(target_dir, "#{basename}.scss")
    source = IO.read(path)
    source = source.gsub(/url\('\.\.\/fonts\/(.+?)'\)/, "url(font-path('metro/\\1'))")
    File.open(target_path, 'w') do |file|
      file.print source
    end
  end

  File.open("#{stylesheet_dir}/metro.css", 'w') do |file|
    paths.each do |path|
      basename = File.basename(path)
      file.puts "//= require metro/#{basename}"
    end
  end
end

desc 'Generate fonts'
task fonts: :submodule do
  Rake.rake_output_message 'Generating fonts'

  font_dir = 'vendor/assets/fonts'
  target_dir = "#{font_dir}/metro"
  mkdir_p target_dir

  paths = Dir.glob('Metro-UI-CSS/fonts/*')

  paths.each do |path|
    basename = File.basename(path)
    target_path = File.join(target_dir, basename)
    cp path, target_path
  end
end

desc 'Update MetroUiCss::Rails::METRO_UI_CSS_VERSION'
task version: :submodule do
  Rake.rake_output_message 'Updating MetroUiCss::Rails::METRO_UI_CSS_VERSION'

  version = JSON.parse(IO.read('./Metro-UI-CSS/bower.json'))['version']

  version_path = 'lib//metro_ui_css/rails/version.rb'
  source = IO.read(version_path)
  source = source.sub(/METRO_UI_CSS_VERSION = '[^']*'/, "METRO_UI_CSS_VERSION = '#{version}'")
  File.open(version_path, 'w') do |out|
    out.write(source)
  end
end

desc 'Generate assets'
task assets: [:clean, :javascripts, :stylesheets, :fonts, :version]

task default: :assets
