# we need to do the javascript tricks to do the view part

# steps:
# 1. all the template should still be the .erb files

# todos.erb
# <% render_yoyo_component :todo, flow: @todo_flow, collection: true %>

# coffee
class Todo < Yoyo::Component
  # and in the coffee component
  @todo_flow
  @special_flow
end


# so the main goal of the flow is just to
# 1. wrap every url request as flow, and do the tracks in the back
# 2. don't need to know about only rails knowledge when developing the frontend
# 3. the js.erb view file should just wrap the flow in it, which means when we do a
# ajax request, we should return a new flow which will do the view change tracks in the
# view or just do refresh on the client server.
