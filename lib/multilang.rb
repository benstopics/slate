module Multilang
  def block_code(code, full_lang_name)
    if full_lang_name
      # Split language name and handle cases like `javascript--tab1`
      parts = full_lang_name.split('--')
      rouge_lang_name = parts[0] # Get the primary language for Rouge
      tab_class = "tab-#{full_lang_name}" # Additional custom class

      plain_code = code.gsub(/<[^>]*>/, '') # Remove HTML tags

      print "plain_code: #{plain_code}\n"

      random_fiddle_id = rand(36**8).to_s(36) # Generate a random fiddle ID

      # Custom HTML output with desired classes
      <<~HTML
        <div class="highlight">
          <pre class="highlight #{rouge_lang_name} #{tab_class}"><div fiddledocs-id="#{random_fiddle_id}"></div></pre>
        </div>
      HTML
    else
      # Default behavior when no language is specified
      # <<~HTML
      #   <div class="custom-code-block no-lang">
      #     <pre><code>Hello World!</code></pre>
      #   </div>
      # HTML
      
      super(code, full_lang_name)
    end
  end
end

require 'middleman-core/renderers/redcarpet'
Middleman::Renderers::MiddlemanRedcarpetHTML.send :include, Multilang