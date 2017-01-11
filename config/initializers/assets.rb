# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile = ['*.js', '*.scss', '*.css']
Rails.application.config.assets.precompile += %w(*.svg *.eot *.woff *.ttf *.gif *.png *.ico)
Rails.application.config.assets.precompile += %w( video-js.swf vjs.eot vjs.svg vjs.ttf vjs.woff )

# Add additional assets to the asset load path
Rails.application.config.assets.enabled = true
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "plugins")
