<p id="notice"><%= notice %></p>
<h1>Edit User Page</h1>

<% if @user.errors.any? %>
 <div id="error_explanation">
   <h2><%= pluralize(@user.errors.count, "error") %> prohibited this <%= @user.name %> from being saved:</h2>

   <ul>
     <% @user.errors.full_messages.each do |message| %>
      <li><%= message %></li>
     <% end %>
   </ul>
 </div>
<% end %>
<%= form_with(model: @user, local: true) do |f| %>
  <div class="field">
    <%= f.label :name %><br>
    <%= f.text_field :name, class:"form-control" %>
  </div>

 <div class="field">
   <%= f.label :email %><br>
   <%= f.email_field :email, class:"form-control" %>
 </div>

 <div class="field">
   <%= f.label :password %><br>
   <%= f.password_field :password, class:"form-control" %>
 </div>

 <div class="field">
   <%= f.label :password_confirmation %><br>
   <%= f.password_field :password_confirmation, class:"form-control" %>
 </div>

 <div class="actions">
   <%= f.submit "Edit details", class:"btn btn-primary btn-lg" %>
 </div>

 <% end %>
<hr>
<%= link_to 'back', user_path(@user), class:"btn btn-info btn-lg" %> |
<%= link_to 'Main', tasks_path, class:"btn btn-default btn-lg" %>
