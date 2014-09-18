module MetroUiCss
  module Rails
    class Engine < ::Rails::Engine
      initializer 'metro_ui_css-rails.setup' do |app|
        app.config.assets.precompile << %r(\Ametro/.+\.(:?ttf|woff|svg)\Z)
      end
    end
  end
end
