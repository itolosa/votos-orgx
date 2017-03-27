# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

section = Section.create(name: 'Nombre seccion')
fronts = []
fronts << Front.create(name: 'Nombre de frente')
activist = Activist.new(name: 'Admin', email: 'admin@example.com', section: section, fronts: fronts, password: "secret123")
activist.add_role :admin
activist.save!

candidato = Candidate.create(name: 'Nombre candidato 1')
candidato = Candidate.create(name: 'Nombre candidato 2')
candidato = Candidate.create(name: 'Nombre candidato 3')
candidato = Candidate.create(name: 'Nombre candidato 4')
candidato = Candidate.create(name: 'Nombre candidato 5')
candidato = Candidate.create(name: 'Nombre candidato 6')
candidato = Candidate.create(name: 'Nombre candidato 7')