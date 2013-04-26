# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new
admin.name = "admin"
admin.password = "changeme"
admin.save!

post = Post.new
post.title = "First Post!"
post.url_title = "very-first-post"
post.body = "This is your first post. " * 30
post.release_date = Time.now
post.modify_date = Time.now
post.hidden = 0
post.hits = 0
post.save!

