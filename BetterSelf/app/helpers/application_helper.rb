module ApplicationHelper

  def auth_token_input
    <<-HTML.html_safe
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML
  end

  def button_to(text, url, options = { method: :post })
    <<-HTML.html_safe
    <form action="#{url}"
          method="POST">
          #{auth_token_input}
          <input type="hidden"
                name="_method"
                value="#{options[:method]}">
      <input type="submit" value="#{text}">
    </form>
    HTML

  end
end
