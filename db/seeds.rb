print '🗑  Delete database...........'
Action.destroy_all
Comment.destroy_all
User.destroy_all
Project.destroy_all
puts '✔'

print '🌱 Seed users................'
user = User.create!(email: 'user@example.com', password: 'password')
user2 = User.create!(email: 'user2@example.com', password: 'password')
puts '✔'


print '🌱 Seed projects.............'
project = Project.create!(title: 'Kappsport')
Registration.create!(
  project: project,
  user: user
)
project2 = Project.create!(title: 'Sekurit form')
Registration.create!(
  project: project2,
  user: user
)
Registration.create!(
  project: project2,
  user: user2
)
project3 = Project.create!(title: 'Sekurit landing')
Registration.create!(
  project: project3,
  user: user
)
puts '✔'


print '🌱 Seed issues...............'
issue = Issue.create!(
  project: project,
  title: 'Missing word in card 2'
)

action = Action.create!(
  title: :opened,
  user: user
)

issue.issue_feeds.create!(
  issue: issue,
  feed_type: Action,
  feed: action
)


issue = Issue.create!(
  project: project,
  title: 'Bug in search'
)

action = Action.create!(
  title: :opened,
  user: user
)

issue.issue_feeds.create!(
  issue: issue,
  feed_type: Action,
  feed: action
)

issue = Issue.create!(
  project: project2,
  title: 'Missing word in card 2'
)

action = Action.create!(
  title: :opened,
  user: user
)

issue.issue_feeds.create!(
  issue: issue,
  feed_type: Action,
  feed: action
)

issue = Issue.create!(
  project: project2,
  title: 'Bug in search'
)

action = Action.create!(
  title: :opened,
  user: user
)

issue.issue_feeds.create!(
  issue: issue,
  feed_type: Action,
  feed: action
)

issue = Issue.create!(
  project: project2,
  title: 'Change color in title'
)

action = Action.create!(
  title: :opened,
  user: user
)

issue.issue_feeds.create!(
  issue: issue,
  feed_type: Action,
  feed: action
)
puts '✔'
