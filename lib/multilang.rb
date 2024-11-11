module Multilang
  def block_code(code, full_lang_name)
    if full_lang_name
      # Split language name and handle cases like `javascript--tab1`
      parts = full_lang_name.split('--')
      rouge_lang_name = parts[0] # Get the primary language for Rouge
      tab_class = "tab-#{full_lang_name}" # Additional custom class

      plain_code = code.gsub(/<[^>]*>/, '') # Remove HTML tags

      # Parse growthdocs-id=<id> from the code block
      growthdocs_id = plain_code.match(/growthdocs-id=(.+)/)&.captures&.first

      if growthdocs_id
        # Custom HTML output with desired classes
        <<~HTML
          <div class="highlight">
            <pre class="highlight #{rouge_lang_name} #{tab_class}"><div growthdocs-id="#{growthdocs_id}"></div></pre>
          </div>
        HTML
      else
        super(code, rouge_lang_name).sub("highlight #{rouge_lang_name}") do |match|
          match + " tab-" + full_lang_name
        end
      end
    else
      super(code, full_lang_name)
    end
  end
end

require 'middleman-core/renderers/redcarpet'
Middleman::Renderers::MiddlemanRedcarpetHTML.send :include, Multilang