class IssueQuery < BaseQuery
  def self.relation(base_relation=nil)
    super(base_relation, Issue)
  end

  def include_actions
    includes(actions: :user)
  end
end
