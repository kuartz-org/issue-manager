class ProjectQuery < BaseQuery
  def self.relation(base_relation=nil)
    super(base_relation, Project)
  end
end
