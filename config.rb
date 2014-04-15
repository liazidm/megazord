
http_path = "/"
css_dir = "css"
sass_dir = "sass"
images_dir = "images"
javascripts_dir = "js"
debug_info = true
environment = "development"
output_style = :expanded
line_comments = true

on_stylesheet_saved do |file|
    `compass compile -c config_prod.rb --force`
end