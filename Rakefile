require 'bundler/gem_tasks'

task :submodule do
  sh 'git submodule update --init' unless File.exist?('Metro-UI-CSS/README.md')
end

task :clean do
  rm_rf 'vendor'
end

desc 'Generate JavaScript assets'
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

desc 'Generate CSS assets'
task stylesheets: :submodule do
  Rake.rake_output_message 'Generating stylesheets'

  stylesheet_dir = 'vendor/assets/stylesheets'
  target_dir = "#{stylesheet_dir}/metro"
  mkdir_p target_dir

  paths = Dir.glob('Metro-UI-CSS/css/*.css')

  paths.each do |path|
    basename = File.basename(path)
    target_path = File.join(target_dir, basename)
    cp path, target_path
  end

  File.open("#{stylesheet_dir}/metro.css", 'w') do |file|
    paths.each do |path|
      basename = File.basename(path)
      file.puts "//= require metro/#{basename}"
    end
  end
end

desc 'Generate Font assets'
task fonts: :submodule do
  Rake.rake_output_message 'Generating stylesheets'

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

desc 'Generate assets'
task assets: [:clean, :javascripts, :stylesheets, :fonts]

task default: :assets
