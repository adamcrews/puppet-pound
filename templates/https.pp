ListenHTTPS
  Address <%= @address %>
  Port <%= @port %>
  Cert <%= @cert %>
End

Service
  <%- @backend.each_pair do |back_addr, back_port| -%>
  BackEnd
    Address <% back_addr %>
    Port <% back_port %>
  End
  <%- end -%>
  <%- if @session -%>
  Session
    <%- @session.each_pair do |key, val| -%>
    <%= key %>  <%= val %>
  End
  <%- end -%>
End
