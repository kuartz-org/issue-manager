Action.destroy_all
User.destroy_all
Project.destroy_all

user = User.create!(email: 'user@example.com', password: 'password')
project = Project.create!(title: 'This awesome project')
Registration.create!(
  project: project,
  user: user
)

issue = Issue.create!(
  project: project,
  title: 'Missing word in card 2'
)

issue.actions.create!(
  title: :opened,
  user: user
)

issue = Issue.create!(
  project: project,
  title: 'Bug in search'
)

issue.actions.create!(
  title: :opened,
  user: user
)
