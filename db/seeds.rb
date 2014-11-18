# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

LinkSource.delete_all

LinkSource.new name: "cnn", photo: "cnn.jpg"
LinkSource.new name: "good_reads", photo: "good_reads.jpg"
LinkSource.new name: "emol", photo: "emol.jpg"
LinkSource.new name: "twitter", photo: "twitter.jpg"
LinkSource.new name: "bbc", photo: "bbc.jpg"
LinkSource.new name: "gobierno_de_chile", photo: "gobierno.jpg"