require 'rails_helper'

RSpec.describe ProjectQuery, type: 'query' do
  subject(:query) do
    ProjectQuery.relation(projects)
  end

  let(:projects) do
    projects = []
    
    project = create(:project)

    create(:issue, project: project, title: 'Bug', status: 'open')
    create(:issue, project: project, title: 'New feature', status: 'open')
    create(:issue, project: project, title: 'Typo', status: 'closed')

    projects << project
    
    empty_project = create(:project)
    projects << empty_project

    only_closed_issues_project = create(:project)
    create(:issue, project: only_closed_issues_project, title: 'Bug', status: 'closed')
    create(:issue, project: only_closed_issues_project, title: 'New feature', status: 'closed')
    create(:issue, project: only_closed_issues_project, title: 'Typo', status: 'closed')
    projects << only_closed_issues_project

    return projects
  end

  describe '#with_open_issues_count' do
    # before :each do
    # end

    it 'returns an ActiveRecord AssociationRelation' do
      expect(query.with_open_issues_count).to be_an(ActiveRecord::AssociationRelation)
    end

    it 'returns projects with open issues count' do
      projects = query.with_open_issues_count
      expect(projects[0].open_issues_count).to eq(2)
      expect(projects[1].open_issues_count).to eq(0)
      expect(projects[2].open_issues_count).to eq(0)
    end
  end
end
