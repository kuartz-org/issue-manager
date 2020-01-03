class ProjectQuery < BaseQuery
  def self.relation(base_relation=nil)
    super(base_relation, Project)
  end

  def with_open_issues_count
    select('projects.*, COUNT(issues.id) AS open_issues_count').
      left_outer_joins(:issues).
      where(issues: { status: 'open' }).
      group('projects.id')
  end
end
