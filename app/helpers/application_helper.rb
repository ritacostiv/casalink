module ApplicationHelper
  def avatar_color(user)
    colors = ['#F9D5CB', '#F8B195', '#F67280', '#C06C84', '#6C5B7B', '#355C7D', '#99B898', '#FECEA8']
    colors[user.id % colors.size]
  end
end
