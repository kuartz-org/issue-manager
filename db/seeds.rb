User.destroy_all
Registration.destroy_all
Project.destroy_all

user = User.create!(email: 'user@example.com', password: 'password')
project = Project.create!(title: 'Project X')
Registration.create!(
  project: project,
  user: user
)
