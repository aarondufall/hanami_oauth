class UserRepository < Hanami::Repository
  def self.auth!(auth_hash)
    info = auth_hash[:info]
    github_id = auth_hash[:uid]
    attrs = {
      name:   info[:name],
      email:  info[:email],
    }

    instance = new
    user = instance.users.where(github_id: github_id).first
    if user
      instance.update(user.id, attrs.merge(github_id: github_id))
    else
      instance.create(attrs.merge(github_id: github_id))
    end
  end
end
